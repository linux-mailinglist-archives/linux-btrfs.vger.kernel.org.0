Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A874967EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 23:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiAUWmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 17:42:31 -0500
Received: from multitrading.dk ([92.246.25.51]:38072 "EHLO multitrading.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbiAUWmb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 17:42:31 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jan 2022 17:42:30 EST
Received: (qmail 2244 invoked by uid 89); 21 Jan 2022 22:35:48 -0000
Received: from multitrading.dk (HELO ?10.0.3.10?) (jb@multitrading.dk@92.246.25.51)
  by multitrading.dk with ESMTPA
  for <linux-btrfs@vger.kernel.org>; 21 Jan 2022 22:35:48 -0000
Date:   Fri, 21 Jan 2022 23:35:41 +0100
From:   Jens Bauer <jens@plustv.dk>
To:     linux-btrfs@vger.kernel.org
Message-ID: <20220121233541361696.089bb784@plustv.dk>
Subject: A couple of convenience scripts
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: GyazMail version 1.5.21
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all.

As I'm not a fan of typing long command-lines once a month, I made myself a couple of convenient scripts for scrubbing.
I don't know if there are already scripts like these, but I'm posting them in case someone find them useful.

There might be bugs, if so, they're likely just minor, as I've been using/modifying the scripts all day on 3 different machines. If you find anything you think is incorrect, feel free to let me know.


Show scrub status on selected or all BTRFS volumes:
--8<-----8<---{ ~/bin/Scrub-status }--8<---
#!/bin/bash

# Usage:
#   Scrub-status [volume] ...
# ... or watch all while updating every 5 seconds ...
# Cls; while [ 1 ]; do Home; Scrub-status; sleep 5; done

[ "$EUID" == "0" ] || { sudo -E $0 $@ && exit 0; exit 1; }

# Hint: Cls, Home, CMsg and BTRFS-df can be handy to have in ~/.bash_functions
Cls(){ echo -en "\033c"; }
Home(){ echo -en "\033[H"; }
CMsg(){ echo -en "\033[1;$1m${*:2}\033[m${2:+\n}"; }

BTRFS-df(){ df -h --type=btrfs --output=used,target | tail -n +2 | sort -h; }
BTRFS-status(){ btrfs scrub status "$1"; }
GETVAL(){ local val=$(egrep "^$2:" <<< "$1"); val="${val#$2:}"; echo "${val##* }"; }
BTRFS-state(){ GETVAL "$1" "Status"; }
BTRFS-timeLeft(){ GETVAL "$1" "Time left"; }

volumes=("$@");
[ -z "$*" ] && volumes=($(BTRFS-df | grep -oP '\S+$'))

h=0; for vol in "${volumes[@]}"; do [ ${#vol} -gt $h ] && h=${#vol}; done

for vol in "${volumes[@]}"; do
  volume="$vol                    "
  status=$(BTRFS-status "$vol")
  state=$(BTRFS-state "$status")
  time=$(BTRFS-timeLeft "$status")
  color=30
  case "$state" in finished) color=32 ;; running) color=34 ;; *) state="?" ;; esac
  echo -n "${volume:0:$h}: "; CMsg $color "$state${time:+  (time left: $time)}\033[K"
done
--->8----->8----->8--


Scrubbing selected or all BTRFS-volumes:
--8<-----8<---{ ~/bin/scrub }--8<---
#!/bin/bash

# Usage:
# scrub [vol] ...
#  -If not supplying any arguments, all BTRFS-volumes will be scrubbed.
# otherwise, supply the volumes you want scrubbed ...
# scrub /home /usr /mnt/files
# Scrub all in the background ...
# sudo true; scrub &
# ... quietly ...
# sudo true; scrub >/dev/null 2>&1 &

[ "$EUID" == "0" ] || { sudo -E $0 $@ && exit 0; exit 1; }

BTRFS-df(){ df -h --type=btrfs --output=used,target | tail -n +2 | sort -h; }
BTRFS-status(){ btrfs scrub status "$1"; }
GETVAL(){ local val=$(egrep "^$2:" <<< "$1"); val="${val#$2:}"; echo "${val##* }"; }
BTRFS-state(){ GETVAL "$1" "Status"; }
BTRFS-timeLeft(){ GETVAL "$1" "Time left"; }

scrubTimeLeft(){
  local status state t h m s=1

  while [ -z "$state" ]; do
    status=$(BTRFS-status "$1")
    state=$(BTRFS-state "$status")
    t=$(BTRFS-timeLeft "$status")
  done

  case "$state" in finished) s=0 ;;
  running) [ -n "$t" ] && {
    s=${t##*:}; t=${t%%:$s}; s=${s##*0}
    m=${t##*:}; t=${t%%:$m}; m=${m##*0}
    h=${t##*:}; t=${t%%:$h}; h=${h##*0}
    s=$((${h:-0}*3600+${m:-0}*60+${s:-0}))
  } ;; esac
  echo ${s:-0}
}

waitFor(){
  local seconds=1
  while [ $seconds -ne 0 ]; do
    sleep $seconds
    seconds=$(scrubTimeLeft "$1")
  done
}

volumes=("$@")
[ -z "$*" ] && volumes=($(BTRFS-df | grep -oP '\S+$'))

echo "Will scrub: ${volumes[@]}" >&2

for vol in "${volumes[@]}"; do
  [ -d "$vol" ] && {
    btrfs scrub start "$vol"
    waitFor "$vol"
    echo "Scrubbing finished on $vol" >&2
    sleep 2
  }
done
--->8----->8----->8--

My BTRFS-df function lists the BTRFS volumes sorted by usage.
This is useful for quickly getting the smallest volumes scrubbed first.

If you choose to have a ~/.bash_functions script like I do, just add the following line in your ~/.bashrc right after your ~/.bash_aliases line:

[ -x ~/.bash_functions ] && . ~/.bash_functions

(I have both at the absolute top of my ~/.bashrc ... you may choose to use -f instead of -x if you wish)
Since most commands are lowercase, I've started most of the functions with capital letters to avoid conflicts.

Enjoy.


Love
Jens

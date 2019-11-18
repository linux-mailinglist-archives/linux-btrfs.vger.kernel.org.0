Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4801005F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRM5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 07:57:01 -0500
Received: from smtp01.belwue.de ([129.143.71.86]:40947 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfKRM5A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 07:57:00 -0500
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id E14C48B6C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 13:56:57 +0100 (MET)
Date:   Mon, 18 Nov 2019 13:56:57 +0100
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs based backup?
Message-ID: <20191118125657.GA4166@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue 2019-11-12 (19:34), Ulli Horlacher wrote:

> I need a new backup system for some servers. Destination is a RAID, not
> tapes.
> 
> So far I have used a self written shell script. 25 years old, over 1000
> lines of (HORRIBLE) code, no longer maintenable :-}

Thanks for all your suggestions, but I found myself a really easy solution
just with btrfs+rsync.

On the clients I use:

root@tandem:~# grep backup /etc/fstab 
mutter:/backup/rsync/tandem     /backup         nfs ro,tcp,soft,retrans=1 0 0

root@tandem:~# cat bin/rsync_backup 
#!/bin/bash

exclude='
--exclude=.snapshot
--exclude=.del
--exclude=*.iso
--exclude=tmp/*
--exclude=backup
'

if [ ! -t 0 ]; then
  exec >>/var/log/backup.log
  chmod 600 /var/log/backup.log
  echo
  date +"%Y-%m-%d %H:%M:%S"
fi

mount /backup
mount -o remount,rw /backup || exit 1
rsync -vaxH --delete $exclude / /export /backup/
touch /backup/.ready
mount -o remount,ro /backup


On the backup server I use:

root@mutter:/backup/rsync# grep backup /etc/crontab 
0  *    * * *   root    /backup/rsync/snapshot >/dev/null

root@mutter:/backup/rsync# cat snapshot 
#!/bin/bash

PATH="$PATH:/opt/btrfs-tools/bin"

for i in /backup/rsync/*/.ready; do
  if [ -f "$i" ]; then
    rm $i
    snaprotate rsync 10 $(dirname $i)
  fi
done



That's all! Works like a charm :-)
And substitutes an unmaintainable 1000+ lines shell script.



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20191112183425.GA1257@tik.uni-stuttgart.de>

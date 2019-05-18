Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C202238A
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfERNTc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 May 2019 09:19:32 -0400
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:54931 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERNTc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 09:19:32 -0400
Received: from [94.217.151.102] (helo=[192.168.177.20])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hRzFI-00036a-TK; Sat, 18 May 2019 15:19:28 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Rowland penny" <rpenny@samba.org>, samba@lists.samba.org,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re[2]: [Samba] Fw: Btrfs Samba and Quotas
Date:   Sat, 18 May 2019 13:19:26 +0000
Message-Id: <em24499f72-5f4d-4fc2-8998-b81b877d8d3f@ryzen>
In-Reply-To: <bd91e229-90cc-f30e-1709-d8c55818af1a@samba.org>
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
 <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
 <bd91e229-90cc-f30e-1709-d8c55818af1a@samba.org>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello

>No, probably a lack of users using your combination of Samba, btrfs and quotas.
I would have thought that btrfs is becoming more mainstream now. And 
then, Samba and Quotas should be rather common...
>

>Of course, more info may help, what is in your smb.conf etc.
Added at the end of this mail.

>Why are you using a filesystem that your OS doesn't officially support ?
That implies, that it would be better with any other OS. Are you saying, 
that this is a known samba bug, that has been fixed, but the fix has 
just not yet made it into Debian? Otherwise, I don't understand the 
background of the question.
Appart from that:
Btrfs support was introduced in DebianSqueeze 
<https://wiki.debian.org/DebianSqueeze>.

>
 > I tried brtfs several times together with samba and (sorry to say this)
 > it just a pain in the a.. Never use it together with quotas or CTDB it
 > will crash after short time. I only take xfs and have no problem at all.
 > I don't know wy, but it's not good idea to user brtfs with samba.

Well, as long as this is not being reported and being improved, it will remain that way...

 > I wonder, are your clients Linux or Windows systems?
Windows (10)

 > I wonder if upgrading servers may not be so wise.
What do you mean by that?

Regards,
Hendrik


>
>


cat /etc/samba/smb.conf
#======================= Global Settings =======================
[global]
workgroup = WORKGROUP
server string = %h server
dns proxy = no
log level = 1
log file = /var/log/samba/log.%m
max log size = 1000
logging = syslog
panic action = /usr/share/samba/panic-action %d
encrypt passwords = true
passdb backend = tdbsam
obey pam restrictions = no
unix password sync = no
passwd program = /usr/bin/passwd %u
passwd chat = *Enter\snew\s*\spassword:* %n\n 
*Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
pam password change = yes
socket options = TCP_NODELAY IPTOS_LOWDELAY
guest account = nobody
load printers = no
disable spoolss = yes
printing = bsd
printcap name = /dev/null
unix extensions = yes
wide links = no
create mask = 0777
directory mask = 0777
use sendfile = yes
aio read size = 16384
aio write size = 16384
local master = yes
time server = no
wins support = no


[Dokumente]
path = /srv/dev-disk-by-label-DataPool1/Dokumente
guest ok = no
read only = no
browseable = yes
inherit acls = yes
inherit permissions = no
ea support = no
store dos attributes = no
vfs objects =
printable = no
create mask = 0664
force create mode = 0664
directory mask = 0775
force directory mode = 0775
hide special files = yes
follow symlinks = yes
hide dot files = yes
valid users = "henfri"
invalid users =
read list =
write list = "henfri"



>


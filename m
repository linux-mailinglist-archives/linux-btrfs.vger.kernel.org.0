Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724D71F7266
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 05:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFLDP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 23:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLDP5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 23:15:57 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B5C03E96F
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 20:15:57 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id m25so4528080vsp.8
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fT3vHfNQKunL8lCHNmWruTmPcSH3LFwNtvaQRzCUpFk=;
        b=G0LtrctoC9ITXFKme4hGT5nO9WYgaLdn9RyQ9NmMwU+M8Z3X59Mk/TK3jZlKjQUwsX
         97neAGeDGtQ/WX8c7fvoVpidrOjRi2mvUgZnPro9pohoyaM1Qe5MI4lfFM8aM2U3igOn
         +dFemmvUN18hsV5nTlrS3vqjPnzpe55xxd3kZkLAUckGFelyB3CAJdKbJawDEqIoftQw
         9q9ei5/2v/b4w0XYge0TDcfN+XOd3fmSkodXhp+1ETEzzcM8tj9NCULqjMe2QGzbIzse
         R86pAmcTUf0IMV3FuT/G48ASwJOvrP5tWJX7tbElTvcUzS6wTrjrzZWsUORvv+5G+5Cg
         FPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=fT3vHfNQKunL8lCHNmWruTmPcSH3LFwNtvaQRzCUpFk=;
        b=nzU6hzGWZeuZnDS6WcmZWhnQfzQ4S8mACfIZTIzqeZ5yBzlXvTAaXeMiqAb0TqWUpM
         vk+zL/XJiV4z8Ec2ewUeGcNb9QxO57NeYUqLQAQLXb1mc3Y4hcaSlXx81ef8rgkCZKda
         PhkZX6f6ggDhADVxTMMopKpDc1qysgvDlx8lzQOt1q2yDNcD2PSyvSeiC9REiZqZF+n+
         fWqhhEvKbBL1qEf287Sm5BiaNd7bXnRi/7txQRQt0etsTsBlyjD7O45QNdKDlzt4bF2e
         HAtTfZX0ySvKFCMaiwiyJ+qtuTm6HvwBwXRHrnVp64Pitr4X/JTNHXWrvKPbpQYQzjOn
         4+cA==
X-Gm-Message-State: AOAM531iOrau6Ua4HZ4McSBzbIyYr7naUVvfiikrccQjR4y2bBWLIOz8
        wAKSIzt0m/k5e7B0CUlvI0mlwcXN98U1XFvnrTw=
X-Google-Smtp-Source: ABdhPJy/m322FwTuvsqnoi7HWE11dNOKjUJB0jqUwIAm7ax0NhHxKRtl7n+3HTIp8u9itl6ll3Qt/vfky864BIZWf64=
X-Received: by 2002:a67:b405:: with SMTP id x5mr8658294vsl.79.1591931756075;
 Thu, 11 Jun 2020 20:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz> <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
In-Reply-To: <20200611135244.GP27795@twin.jikos.cz>
From:   Greed Rong <greedrong@gmail.com>
Date:   Fri, 12 Jun 2020 11:15:43 +0800
Message-ID: <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Greed Rong <greedrong@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This server is used for network storage. When a new client arrives, I
create a snapshot of the workspace subvolume for this client. And
delete it when the client disconnects.
Most workspaces are PC game programs. It contains thousands of files
and Its size ranges from 1GB to 20GB.
About 200 windows clients access this server through samba. About 20
snapshots create/delete in one minute.

# lsof | wc -l
47405

# sysctl fs.file-max
fs.file-max =3D 39579457

# sysctl fs.file-nr
fs.file-nr =3D 5120    0    39579457

# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 1547267
max locked memory       (kbytes, -l) 16384
max memory size         (kbytes, -m) unlimited
open files                      (-n) 102400
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 1547267
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

On Thu, Jun 11, 2020 at 9:52 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jun 11, 2020 at 08:37:11PM +0800, Qu Wenruo wrote:
> >
> >
> > On 2020/6/11 =E4=B8=8B=E5=8D=887:20, David Sterba wrote:
> > > On Thu, Jun 11, 2020 at 06:29:34PM +0800, Greed Rong wrote:
> > >> Hi,
> > >> I have got this error several times. Are there any suggestions to av=
oid this?
> > >>
> > >> # dmesg
> > >> [7142286.563596] ------------[ cut here ]------------
> > >> [7142286.564499] BTRFS: Transaction aborted (error -24)
> > >
> > > EMFILE          24      /* Too many open files */
> > >
> > > you can increase the open file limit but it's strange that this happe=
ns,
> > > first time I see this.
> >
> > Not something from btrfs code, thus it must come from the VFS/MM code.
>
> Yeah, this is VFS. Creating a new root will need a new inode and dentry
> and the limits are applied.
>
> > The offending abort transaction is from btrfs_read_fs_root_no_name(),
> > which is updated to btrfs_get_fs_root() in upstream kernel.
> > Overall, it's not much different between the upstream and the 5.0.10 ke=
rnel.
> >
> > But with latest btrfs_get_fs_root(), after a quick glance, there isn't
> > any obvious location to introduce the EMFILE error.
> >
> > Any extra info about the worload to trigger the bug?
>
> I think it's from get_anon_bdev, that's called from btrfs_init_fs_root
> (in btrfs_get_fs_root):
>
> 1073 int get_anon_bdev(dev_t *p)
> 1074 {
> 1075         int dev;
> 1076
> 1077         /*
> 1078          * Many userspace utilities consider an FSID of 0 invalid.
> 1079          * Always return at least 1 from get_anon_bdev.
> 1080          */
> 1081         dev =3D ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORBITS=
) - 1,
> 1082                         GFP_ATOMIC);
> 1083         if (dev =3D=3D -ENOSPC)
> 1084                 dev =3D -EMFILE;
> 1085         if (dev < 0)
> 1086                 return dev;
> 1087
> 1088         *p =3D MKDEV(0, dev);
> 1089         return 0;
> 1090 }
> 1091 EXPORT_SYMBOL(get_anon_bdev);
>
> And comment says "Return: 0 on success, -EMFILE if there are no
> anonymous bdevs left ".
>
> The fs tree roots are created later than the actual command is executed,
> so all the errors are also delayed. For that reason I moved eg. the root
> item and path allocation to the first phase. We could do the same for
> the anonymous bdev.
>
> The problem won't go away tough, the question is why is the IDA range
> unnamed_dev_ida exhausted.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A426B52037
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 03:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfFYBBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 21:01:39 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40278 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfFYBBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 21:01:39 -0400
Received: by mail-wm1-f51.google.com with SMTP id v19so1070785wmj.5
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6k+57qvIoUeaEr5MwlabVgsbYfQOCXkd4oVOJxGDvsg=;
        b=UV3tmn06YJqbnw9i+SX8CIF2Pw2+SnyJtPphbPFdUedlsLoUrp2rXz6gMlr679RtVt
         XBEdd2fmoygkgpS3ixrihrJILl0z9MagVaVWkhs2zSXO6A+NFCvNq5VOsS3Eprv2huOu
         LIq2aOpUioj/SjCJUHROsVx43M++F2Ml0mhqaOfdzUCXRhSMVIqkatpEfL1TrSqn6Ptz
         lCUrb3gO1HTWt/UGEhjbu5CvdbImJIPJZ+LHdGMAORA3iQ8BIQyGrVFyIcAoHJp6UzM5
         uAbvxqrFUy66ny4ETd9Ltot0hEdOqLJfCAztwysYEV879sKfOYcaxzOFUJxOu1hHY+iw
         foMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6k+57qvIoUeaEr5MwlabVgsbYfQOCXkd4oVOJxGDvsg=;
        b=ThIgum9hUrUY58IpTvai8HHAZqKItFfJDLMFKdDHDavBwze6ushN9F2btHqqnzSbZ5
         5YzpENcjNP+9TGjyGsD7yivrYyxZys1h3KhEHC5mNQR6gyXCp/KjScw4DDed+JaAvQrp
         hcWZ9Xw4HumC0mmkxxw5Qi0ZKxVFbbloV43SupYUqXorOTpyTkvvfFjvvvdEuvr2gh/F
         VBIff/szCC58q8Sg2vndVWxwcNLeoOLFpR21LgUE3SnCFIh4dx6Sef6ZbIkIJNHYrmT3
         xXMMwjdx9B1EjKuoIY0i9K8IUVBEjCubY9IOHrBQplrkDppi5Rd7LJwLtzS/k+0l/DMA
         WtgA==
X-Gm-Message-State: APjAAAVT957cLXmyJugi85RGYCxWZBOhPXqwWzgGLMRh7pHCKhVtXkt8
        VsZY7nc1hhU9A4tFTwdunD4FUllYnxtCq0+MjawUOA==
X-Google-Smtp-Source: APXvYqx/8MTiBfcMVnfFE34V81TnFF4N9rtvm3wOJ+DsRi2w23PWGXIBpUfCXiN5s3v3GqgA50SA/pnt8nIn+wDm9oY=
X-Received: by 2002:a1c:a997:: with SMTP id s145mr17155724wme.106.1561424497095;
 Mon, 24 Jun 2019 18:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com>
In-Reply-To: <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 19:01:26 -0600
Message-ID: <CAJCQCtTdnZFjwsKaEV0Z6bPK+L2mHLv6=zjgrVt0G1ei2AXq5A@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 24, 2019 at 5:48 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> The problem is not complex, one inode which shouldn't go through
> compression (maybe nodatacow or nodatasum set) has go through compression.
>
> This leads to missing csum while still compressed.
>
> This could cause read time error.
>
> The solution should be pretty easy, find inode 4665463 in root 492, and
> remove it.

They are systemd journals. Based on the ctime/mtime they were clearly
modified today, which I don't understand because I've had volatile
journal set for a few days now. But you can see they are set to nocow,
and yet there are zstd compressed extents. We've discussed the case
before, where defragmenting a nocow file while the file system is
mounted with compress option, permits compression. I think that's
what's going on here. I've seen it with zlib and lzo too, but I
haven't used them in years so I don't know if that's still the case. I
know systemd-journald does by default set /var/log/journal with chattr
+C and also defragments journals upon rotation.


    item 106 key (4665463 INODE_ITEM 0) itemoff 49169 itemsize 160
        generation 57085 transid 59069 size 33554432 nbytes 33554432
        block group 0 mode 100640 links 1 uid 0 gid 190 rdev 0
        sequence 6143 flags 0x13(NODATASUM|NODATACOW|PREALLOC)
        atime 1561330326.52881457 (2019-06-23 22:52:06)
        ctime 1561390782.569639513 (2019-06-24 15:39:42)
        mtime 1561390782.443639516 (2019-06-24 15:39:42)
        otime 1561330326.52881457 (2019-06-23 22:52:06)
    item 107 key (4665463 INODE_REF 169326) itemoff 49110 itemsize 59
        index 52 namelen 49 name:
system@00058c139ef35bc6-a1c70e9eca5616e6.journal~
    item 108 key (4665463 XATTR_ITEM 843765919) itemoff 49056 itemsize 54
        location key (0 UNKNOWN.0 0) type XATTR
        transid 57085 data_len 8 name_len 16
        name: user.crtime_usec
    item 109 key (4665463 XATTR_ITEM 2038346239) itemoff 48951 itemsize 105
        location key (0 UNKNOWN.0 0) type XATTR
        transid 57085 data_len 52 name_len 23
        name: system.posix_acl_access
        data
    item 110 key (4665463 XATTR_ITEM 3817753667) itemoff 48874 itemsize 77
        location key (0 UNKNOWN.0 0) type XATTR
        transid 57085 data_len 31 name_len 16
        name: security.selinux
        data system_u:object_r:var_log_t:s0
    item 111 key (4665463 EXTENT_DATA 0) itemoff 48821 itemsize 53
        generation 59069 type 1 (regular)
        extent data disk byte 1115086848 nr 16384
        extent data offset 0 nr 131072 ram 131072
        extent compression 3 (zstd)


Anyway the problem looks minor, the file system itself is fine. But it
does stop the startup process.

-- 
Chris Murphy

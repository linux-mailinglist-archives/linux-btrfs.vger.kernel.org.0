Return-Path: <linux-btrfs+bounces-6689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9E93BEDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 11:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9205B22028
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C4176233;
	Thu, 25 Jul 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+4N2mi3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3381E
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898969; cv=none; b=IjLXD8YA/sLAUnvAW3QP5PmgbKfb2KwY9IlqdBZRjWZ8Jf6ESVzleF6fmL6ZTQRdG8b+YdeQeY3JXXFB/+9Imw8loDZdG67+xyGpWAr9K5CrmMlZVblEt095XfsmVFBy2w8cOQnyOEbtExD7GUYDYCas6Hf2pcOK1ZFMbHvNmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898969; c=relaxed/simple;
	bh=KU2cOPUlwGKroyilBS76gHk1VW+CM/3XU5/K1KpGR70=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=X1KXshy+o3LvkPPIv2NVl8s8LD2+CSj7ZnNqoww/Oy9CvMpRWDmppZ1fYjvdqEmaEi8yaOsinfdW+oRroKM/mi9YbwqaNVRgtzAaRBjT/P/ZdnL0FtSsQjYgnOCjPHN2KmuFNOfTVGgGh0e/XK6FihmR+4YfiD3rkVheYvw1DrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+4N2mi3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721898966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SSfQlJHXSrqhwL7EakHhmyebVQFBsUYzpppEE1Eyo1c=;
	b=I+4N2mi3ykCgCGs6ND0se7CTTjfdcA7uxluqJvC1navgB+tH5d2+lDeqF+doq6o20Cp3Cz
	7tFKIEu5slvGAHI2hs3Dzu0Xdiu0Io6XgY4fQFn5oZaB11HQRxa2INM4a5hIO3KAxz5i9w
	iC0CCqeKjSpekW2qzkHn1q22KhcX0tA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-qyFzbuQWPaygjivIqyljlQ-1; Thu, 25 Jul 2024 05:16:03 -0400
X-MC-Unique: qyFzbuQWPaygjivIqyljlQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7ab06d2d4fso30575066b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898961; x=1722503761;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSfQlJHXSrqhwL7EakHhmyebVQFBsUYzpppEE1Eyo1c=;
        b=ajdYAHSm7RuZPYwyf3jndlwAgqBkn+KRbH1woQnt3NohFxt+GcjTW4/7c81M7LGSkg
         2pRogYzOP4ImvhmW18XqXRusf5ffCKu4znkOvjbARS06jwVXAgZ/5jJ0CwwUcmxkPNBM
         BCa0VQZr4djy/StxP7cJe+QqhN+7qZMMCd6tgvJ7xu79yhzR8js9WSKsgRKttpemymS8
         NhgdTTP8/1j7yjMPYPKx98zzLXv0S3meuvmoVEGA+0pfxcQ8MXa8JoyK3oZNBUdS1bbn
         eFBrLoIzru6Gy+VDCEBjpBKsrvnSq/G2eUMyTYeLqbhsLd7cXWdw9jQJd7SDfnuU1M8H
         ynIA==
X-Gm-Message-State: AOJu0YzPykc3OgAp1YAtfybi9iv9YrJA6QwQzB7ubU4ORvp/fUafi3Ol
	T9NilIAuGejN0bKOKWI/cv6dBkMh+xlRu4e0khtZ0Sba2geGqzb7PqOa94F3bSbXYrHM9bEdMFr
	T5Id9kptLTqSkrmFk5VukApoTUb+tKIo2Rk6n7knp6h2jMOvuCZFvQWUM6anCobmPW70b11Hy4J
	Nu8SJ8vUVu476phGBmw4i0wsSzK1NTIO1YNFkz0d8GPg==
X-Received: by 2002:a17:907:80b:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a7acb404706mr89053166b.20.1721898961237;
        Thu, 25 Jul 2024 02:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSWm6miUz8Jc2fnK+q5rrZH8SgGFkF7rURoRwCiM6pcJS53HcUV5UYcO7EmNNUowVmcTD2Vw==
X-Received: by 2002:a17:907:80b:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a7acb404706mr89049966b.20.1721898960554;
        Thu, 25 Jul 2024 02:16:00 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1c0d:f9c1:fd6b:b3:d669? (p200300cfd74b1c0df9c1fd6b00b3d669.dip0.t-ipconnect.de. [2003:cf:d74b:1c0d:f9c1:fd6b:b3:d669])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad92ffbsm51104466b.171.2024.07.25.02.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:15:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------lC1i1w8n0yX9nM375W3EDah2"
Message-ID: <0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com>
Date: Thu, 25 Jul 2024 11:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
Subject: Appending from unpopulated page creates hole
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Stefano Garzarella <sgarzare@redhat.com>

This is a multi-part message in MIME format.
--------------lC1i1w8n0yX9nM375W3EDah2
Content-Type: multipart/alternative;
 boundary="------------a1f3nPvWwQPL2IAlZlRWQrbh"

--------------a1f3nPvWwQPL2IAlZlRWQrbh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I’ve noticed that appending to a file on btrfs will create a hole before 
the appended data under certain circumstances:

- Appending means O_APPEND or RWF_APPEND,
- Writing is done in direct mode, i.e. O_DIRECT, and
- The source buffer is not present in the page tables (what mmap() calls 
“unpopulated”).

The hole seems to generally have the size of the data being written 
(i.e. a 64k write will create a 64k hole, followed by the 64k of data we 
actually wanted to write), but I assume this is true only up to a 
specific size (depending on how the request is split in the kernel).

I’ve appended a reproducer.

We encounter this problem with virtio-fs (sharing of directories between 
a virtual machine host and guest), where writing is done by virtiofsd, a 
process external to the VMM (e.g. qemu), but the buffer comes from the 
VM guest.  Memory is shared between virtiofsd and the VMM, so virtiofsd 
often writes data from shared memory without having accessed it itself, 
so it isn’t present in virtiofsd’s page tables.

Stefano Garzarella (CC-ed) has tested |some Fedora kernels, and has 
confirmed that this bug does not appear in ||6.0.7-301.fc37.x86_64, but 
does appear in ||6.0.9-300.fc37.x86_64.

While I don’t know anything about btrfs code, I looked into it, and I 
believe the changes made by commit 
8184620ae21213d51eaf2e0bd4186baacb928172 (btrfs: fix lost file sync on 
direct IO write with nowait and dsync iocb) may have caused this.  
Specifically, it changed the `goto again` on EFAULT to `goto relock`, a 
much earlier label, which causes btrfs_direct_write() to call 
generic_write_checks() again after the first btrfs_dio_write() attempt.

btrfs_dio_write() will have already allocated extents for the data and 
updated the file length before trying to actually write the data (which 
generates the EFAULT), so this second generic_write_checks() call will 
update the I/O position to this new file length, exactly at the end of 
the area to where the data was supposed to be written.

To test this hypothesis, I’ve tried skipping the generic_write_checks() 
call after reaching this specific goto, and that does make the bug 
disappear.


Hanna
|
--------------a1f3nPvWwQPL2IAlZlRWQrbh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace">Hi,<br>
      <br>
      I’ve noticed that appending to a file on btrfs will create a hole
      before the appended data under certain circumstances:<br>
      <br>
      - Appending means O_APPEND or RWF_APPEND,<br>
      - Writing is done in direct mode, i.e. O_DIRECT, and<br>
      - The source buffer is not present in the page tables (what mmap()
      calls “unpopulated”).<br>
      <br>
      The hole seems to generally have the size of the data being
      written (i.e. a 64k write will create a 64k hole, followed by the
      64k of data we actually wanted to write), but I assume this is
      true only up to a specific size (depending on how the request is
      split in the kernel).<br>
      <br>
      I’ve appended a reproducer.<br>
      <br>
      We encounter this problem with virtio-fs (sharing of directories
      between a virtual machine host and guest), where writing is done
      by virtiofsd, a process external to the VMM (e.g. qemu), but the
      buffer comes from the VM guest.  Memory is shared between
      virtiofsd and the VMM, so virtiofsd often writes data from shared
      memory without having accessed it itself, so it isn’t present in
      virtiofsd’s page tables.<br>
      <br>
      Stefano Garzarella (CC-ed) has tested <code>some Fedora kernels,
        and has confirmed that this bug does not appear in </code></font><code
      data-stringify-type="code" class="c-mrkdwn__code">6.0.7-301.fc37.x86_64,
      but does appear in </code><code data-stringify-type="code"
      class="c-mrkdwn__code">6.0.9-300.fc37.x86_64.<br>
      <br>
      While I don’t know anything about btrfs code, I looked into it,
      and I believe the changes made by commit
      8184620ae21213d51eaf2e0bd4186baacb928172 (btrfs: fix lost file
      sync on direct IO write with nowait and dsync iocb) may have
      caused this.  Specifically, it changed the `goto again` on EFAULT
      to `goto relock`, a much earlier label, which causes
      btrfs_direct_write() to call generic_write_checks() again after
      the first btrfs_dio_write() attempt.<br>
      <br>
      btrfs_dio_write() will have already allocated extents for the data
      and updated the file length before trying to actually write the
      data (which generates the EFAULT), so this second
      generic_write_checks() call will update the I/O position to this
      new file length, exactly at the end of the area to where the data
      was supposed to be written.<br>
      <br>
      To test this hypothesis, I’ve tried skipping the
      generic_write_checks() call after reaching this specific goto, and
      that does make the bug disappear.<br>
      <br>
      <br>
      Hanna<br>
    </code>
  </body>
</html>

--------------a1f3nPvWwQPL2IAlZlRWQrbh--
--------------lC1i1w8n0yX9nM375W3EDah2
Content-Type: text/x-csrc; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

I2lmbmRlZiBfR05VX1NPVVJDRQojZGVmaW5lIF9HTlVfU09VUkNFCiNlbmRpZgoKI2luY2x1
ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4K
I2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCmludCBtYWluKGlu
dCBhcmdjLCBjaGFyICphcmd2W10pCnsKICAgIGlmIChhcmdjIDwgMikgewogICAgICAgIGZw
cmludGYoc3RkZXJyLCAiVXNhZ2U6ICVzIDx0ZXN0IGZpbGU+XG4iLCBhcmd2WzBdKTsKICAg
ICAgICByZXR1cm4gMTsKICAgIH0KCiAgICBpbnQgZmQgPSBvcGVuKGFyZ3ZbMV0sIE9fV1JP
TkxZIHwgT19DUkVBVCB8IE9fVFJVTkMgfCBPX0RJUkVDVCB8IE9fQVBQRU5ELCAwNjQ0KTsK
ICAgIGlmIChmZCA8IDApIHsKICAgICAgICBwZXJyb3IoImNyZWF0aW5nIHRlc3QgZmlsZSIp
OwogICAgICAgIHJldHVybiAxOwogICAgfQoKICAgIGNoYXIgKmJ1ZiA9IG1tYXAoTlVMTCwg
NDA5NiwgUFJPVF9SRUFELCBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsK
ICAgIHNzaXplX3QgcmV0ID0gd3JpdGUoZmQsIGJ1ZiwgNDA5Nik7CiAgICBpZiAocmV0IDwg
MCkgewogICAgICAgIHBlcnJvcigicHdyaXRldjIiKTsKICAgICAgICByZXR1cm4gMTsKICAg
IH0KCiAgICBzdHJ1Y3Qgc3RhdCBzdGJ1ZjsKICAgIHJldCA9IGZzdGF0KGZkLCAmc3RidWYp
OwogICAgaWYgKHJldCA8IDApIHsKICAgICAgICBwZXJyb3IoInN0YXQiKTsKICAgICAgICBy
ZXR1cm4gMTsKICAgIH0KCiAgICBwcmludGYoInNpemU6ICVsbHVcbiIsICh1bnNpZ25lZCBs
b25nIGxvbmcpc3RidWYuc3Rfc2l6ZSk7CiAgICByZXR1cm4gc3RidWYuc3Rfc2l6ZSA9PSA0
MDk2ID8gMCA6IDE7Cn0K

--------------lC1i1w8n0yX9nM375W3EDah2--



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6F482B8A
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 15:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiABOTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 09:19:48 -0500
Received: from mail1.arhont.com ([178.248.108.111]:60436 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiABOTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jan 2022 09:19:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 92C91400AA4;
        Sun,  2 Jan 2022 14:19:46 +0000 (UTC)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id py4wzeWRz2Cf; Sun,  2 Jan 2022 14:19:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 5A025400AA5;
        Sun,  2 Jan 2022 14:19:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com 5A025400AA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1641133185;
        bh=5WbTvpukWb6ON+wKpm9qkW88kUnmQpTVl04VhMKPN4A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FD9ICldBEfqR8IbfsUjNftjgk0qiOLgrrA9Y/Ai081MBvgtteeQP2xyvecaDR1Aqd
         vEH/DXbzQTHPY52mLzTgjcUb72on6FSY92FQdPPBj7pswv5g4ONCNZ+RcsEvCTB1q+
         7aGQ5cQi9OYNtLqQA5dQR0A8xmH8DgK3+zEhkyr8=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MVUJA_kswilr; Sun,  2 Jan 2022 14:19:45 +0000 (UTC)
Received: from mail1.arhont.com (mail1.arhont.com [10.1.70.26])
        by mail1.arhont.com (Postfix) with ESMTP id 42A0C400AA4;
        Sun,  2 Jan 2022 14:19:45 +0000 (UTC)
Date:   Sun, 2 Jan 2022 14:19:45 +0000 (UTC)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <171674146.2313.1641133185194.JavaMail.zimbra@arhont.com>
In-Reply-To: <20220102140833.2605a773@gecko>
References: <1056918704.2047.1641123173265.JavaMail.zimbra@arhont.com> <20220102140833.2605a773@gecko>
Subject: Re: CEPH to BTRFS over NFS results in no compression
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - GC96 (Linux)/8.8.15_GA_4177)
Thread-Topic: CEPH to BTRFS over NFS results in no compression
Thread-Index: YJTVMXW/0Ro1eVnAD43Z7A5HgQUSAA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for clarification Lukas. I didn't know that. 

I guess the easiest option for me is to recompress snapshots on a daily basis after they get uploaded.

yours,
kos


----- Original Message -----
> From: "Lukas Straub" <lukasstraub2@web.de>
> To: "Konstantin V Gavrilenko" <k.gavrilenko@arhont.com>
> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Sunday, 2 January, 2022 15:08:33
> Subject: Re: CEPH to BTRFS over NFS results in no compression

> On Sun, 2 Jan 2022 11:32:53 +0000 (UTC)
> "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com> wrote:
> 
>> Hi list,
>> 
>> I have noticed an interesting and surprising behaviour of my BTRFS with regards
>> to compression of the files and NFS.
>> 
>> I have BTRFS RAID10 with 8 disks , that is mounted with the "
>> nofail,noatime,space_cache=v2,compress-force=zstd:9,subvol=@cloudstack-secondary"
>> flags and is exported via NFS.
>> 
>> When I create a snapshot of a disk in Cloudstack from CEPH and save it to a
>> secondary storage to this BTRFS RAID10 over NFS, the file does not compress,
>> despite the compress-force mount option being set on FS
>> So in the below example, the file eeceaf0e-9780-408b-a748-1495d517a9b6 was
>> copied over NFS and is not compressed. When I copy the same file directly on a
>> host, it does get compressed pretty well, as per example below.
>> 
>> [...]
>> 
>> 
>> So what I have checked so far what works
>> - after the original files is copied over NFS, the copy of the file using #cp
>> gets compressed.
>> - after the original files is copied over NFS, the original file can be
>> compressed using #btrfs defrag -czstd option
>> - If I copy the original file to some other host, and copy it back via NFS using
>> cp, it does get compressed.
>> 
>> So the problem seems to appear only when the file is exported from Ceph and
>> copied to NFS.
>> 
>> Any hints what could be causing such a behaviour?
>> 
>> 
>> 
>> Yours sincerely,
>> Kos
>> 
> 
> Btrfs doesn't compress direct-io writes. This suggests that whatever you use for
> "I create a snapshot of a disk in Cloudstack from CEPH and save it to a
> secondary storage to this BTRFS RAID10 over NFS", it writes with O_DIRECT.
> 
> Regards,
> Lukas Straub
> 
> --

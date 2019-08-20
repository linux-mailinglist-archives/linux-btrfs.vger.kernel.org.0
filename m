Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625C8968CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 20:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfHTS47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 14:56:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54593 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHTS46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 14:56:58 -0400
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.167] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0A6E9FF804;
        Tue, 20 Aug 2019 18:56:55 +0000 (UTC)
Subject: Re: Unable to mount, even in recovery, parent transid verify failed
 on raid 1
To:     David Radford <croxis@gmail.com>, linux-btrfs@vger.kernel.org
References: <CABJoFDA-ZwF3ZDpajHo3288NcV+_NO5BAsXv7yTe_hqqRNv0PQ@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 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
 BtUAN08OPA==
Message-ID: <79c2e4e9-735b-f526-04be-60069a2149c4@petaramesh.org>
Date:   Tue, 20 Aug 2019 20:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABJoFDA-ZwF3ZDpajHo3288NcV+_NO5BAsXv7yTe_hqqRNv0PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks like the FS suicide I had the first time I upgraded to kernel 5.2...

Le 20/08/2019 à 20:17, David Radford a écrit :
> I have two 2TB spinning disks with full disk btrfs in raid 1. I am
> unable to mount the disks using any method I have found online. I've
> attached what I hope are the relevant logs. I had to edit them down to
> meet the file size limit.
> 
> uname: Linux babylon 5.2.9-arch1-1-custom-btrfs #1 SMP PREEMPT Mon Aug
> 19 06:41:35 PDT 2019 x86_64 GNU/Linux (Standard Arch Linux kernel
> compiled with Qu's new rescue patch
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637)
> 
> btrfs-progs v5.2.1
> 
> [root@babylon ~]# btrfs fi show
> Label: 'linux'  uuid: 3fd368de-157c-4512-8985-2be93a21a371
>     Total devices 1 FS bytes used 102.48GiB
>     devid    1 size 119.24GiB used 110.31GiB path /dev/sdb1
> 
> Label: none  uuid: 2507581c-dec0-4fdd-afe7-1f7c7ff66c6d (this is the
> one unountable)
>     Total devices 2 FS bytes used 1.54TiB
>     devid    1 size 1.82TiB used 790.03GiB path /dev/sdc
>     devid    2 size 1.82TiB used 790.03GiB path /dev/sdd
> 
> mounting with usebackuproot and rescue=skip_bg results in
> [ 1088.130629] BTRFS info (device sdc): trying to use backup root at mount time
> [ 1088.130633] BTRFS info (device sdc): disk space caching is enabled
> [ 1088.130635] BTRFS info (device sdc): has skinny extents
> [ 1088.135907] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.151587] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.151605] BTRFS warning (device sdc): failed to read root (objectid=2): -5
> [ 1088.151902] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152134] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152143] BTRFS warning (device sdc): failed to read root (objectid=2): -5
> [ 1088.152519] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152633] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152640] BTRFS warning (device sdc): failed to read root (objectid=2): -5
> [ 1088.153462] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.153690] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.153699] BTRFS warning (device sdc): failed to read root (objectid=4): -5
> [ 1088.154714] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.154915] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.154921] BTRFS warning (device sdc): failed to read root (objectid=4): -5
> [ 1088.261675] BTRFS error (device sdc): open_ctree failed
> 
> btrfs-find-root log attached
> 
> I do have partial backup but it is a little outdated and would really
> appreciate help either fixing the filesystem, or finding out how to
> recover it with as minimal loss as possible. Thank you for the help!
> 

-- 
ॐ

Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E

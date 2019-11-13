Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABAAFB84A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 20:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfKMTCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 14:02:38 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:57206 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfKMTCi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 14:02:38 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 14:02:37 EST
Received: from venice.bhome ([94.38.75.109])
        by smtp-32.iol.local with ESMTPA
        id UxmdiZy9jhCYOUxmdiFXSc; Wed, 13 Nov 2019 19:54:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1573671267; bh=tbXrutJujp0JW4rM1v2lF1MLzB/oD8Nf5aN32kGxgMQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U8taimtCwt4AukwHM7yAD6W9uiqjY9Q967wdwx6R987GsQcnEMu/5kmARKFchGn/Q
         /OuGiLzS18enRMkX/0wVVFIYvdf46oia4+1meezizYk5cDbYQ9cduqLrCGO/zV2Kkp
         TiPyrZDQVBzY0QF5snY1w1bjptKOUVmHIX1KKCcHliaVn2hebP/v9oCBqYcHQEuOmt
         4XBgzsrTsfyebtoC0kMHCnZH5MLRYSzzCYfsxriFfWMI2GGLgM7gmoCDSO6yAEs27o
         H3ahGZmeA8rN6zPuSXZAWkGeK1sRjMq656if4ikccrxBnQBGSxcJkRNfmxEinAtG+N
         w/kgFFnF9W6Lg==
X-CNFS-Analysis: v=2.3 cv=D9k51cZj c=1 sm=1 tr=0
 a=KzXHLLuG32F0DtnFfJanyA==:117 a=KzXHLLuG32F0DtnFfJanyA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=mzeZn2TJlUqas4qKeq0A:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Does GRUB btrfs support log tree?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com>
 <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
 <20191104193454.GD3001@twin.jikos.cz>
 <CAJCQCtSiDQA4919YDTyQkW7jPkxMds1K32ym=HgO6KHQLzHw+w@mail.gmail.com>
 <d2301902-bd5b-7c5a-0354-a5df21ca8eb3@libero.it>
 <CAJCQCtQm_5L9uvH53O3Qby3Ktwpvsc2_6rUhkBLGeD07RP5a7Q@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <4480d47f-1b1e-d99d-e480-b31220433340@inwind.it>
Date:   Wed, 13 Nov 2019 19:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQm_5L9uvH53O3Qby3Ktwpvsc2_6rUhkBLGeD07RP5a7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH4nAi0EOAIHjMxdfKoxfLWJCp/Jt9cL04czvy+w6F+w7trDcIWxnlEr0uiorFKRBKqDCIuPwCgUDeaM78N8W/G85KXBPuJXqlxQnZxM+3pNTlCX3h9k
 sGewSQxUAM1+u/LCsi2i0nTw22yqQjBUbG2weyrrFbYsT0zdilCpez773BCHiga1qV4ITI+MoNEgG2Mtx3+dfZS0jIrU213d92EuN8ymwRpZt45lzxZ4CjQT
 tZBmoDw+KGi5pv0XwVvQYIOHJ3N5qUM193Q9rT9g9hY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/2019 18.00, Chris Murphy wrote:
>> The GRUB-fs should have the following main requirements:
>> - allow the atomicity guarantee
>> - allow molti-disk setup
>> - allow grub to update some file (grubenv come me as first)
>> - it should require a simple implementation (easy to porting to multiple system, which basically means linux, *bsd and solaris ?)
>> - the speed should be not important
> Plausibly we're most of the way there already, adapting the existing
> "BIOS Boot" partition.
> 
Unfortunately the BIOS Boot partition (which means basically FAT), doesn't have support for "atomicity" nor multidisk..

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72656ADF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 23:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiGGVvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiGGVvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 17:51:21 -0400
Received: from aldebaran.samara.com.es (25.red-83-55-111.dynamicip.rima-tde.net [83.55.111.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8B4564CD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 14:51:19 -0700 (PDT)
Received: from [192.168.2.3] (andromeda.samara.com.es [192.168.2.3])
        by aldebaran.samara.com.es (Postfix) with ESMTP id 49A61940FA7
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 23:51:19 +0200 (CEST)
Message-ID: <7ba553e6-43cd-63e9-d7cc-b8fde50285f2@samara.com.es>
Date:   Thu, 7 Jul 2022 23:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Fernando Peral <fernando@samara.com.es>
Subject: Re: Help with btrfs error
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <71ee4e58-678d-a8d1-9376-45eaead69ad5@samara.com.es>
 <CAJCQCtTjYJVnOwdyyrjW8Uwzv2NoEzLNn4zXR1a_WXMVEDhmMg@mail.gmail.com>
Content-Language: es-ES
In-Reply-To: <CAJCQCtTjYJVnOwdyyrjW8Uwzv2NoEzLNn4zXR1a_WXMVEDhmMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/22 22:54, Chris Murphy wrote:
> On Tue, Jul 5, 2022 at 4:30 AM Fernando Peral<fernando@samara.com.es>  wrote:
>> I have a Opensuse leap 15.3 installed in a ssd disk, on some system
>> updates it crashed. I mouted the disk in other computer to test it and
>> the fs has some errors. I have tried scrub and check and I don't know
>> what to do next, this is the info
>>
>>
>> andromeda:~ # uname -a
>> Linux andromeda 5.3.18-150300.59.76-default #1 SMP Thu Jun 16 04:23:47
>> UTC 2022 (2cc2ade) x86_64 x86_64 x86_64 GNU/Linux
>>
>> andromeda:~ # btrfs --version
>> btrfs-progs v4.19.1
> I'm not really sure what's going on, but there have been improvements
> to the write time tree checker since kernel 5.3. It could still be
> true that a memory related bit flip escaped detection and caused this
> problem. But it could also be an early indication of drive failure.
>
> I suggest updating to a more recent btrfs-progs and running 'btrfs
> check --readonly' and post the output to help confirm the problem.
>
>
>

andromeda:~ #btrfs check --readonly /dev/sdb2
Opening filesystem to check...
Checking filesystem on /dev/sdb2
UUID: 2294e96a-9ccc-4e81-910b-002305654a08
[1/7] checking root items
[2/7] checking extents
ref mismatch on [1619607552 16384] extent item 95, found 1
ref mismatch on [1619623936 16384] extent item 24577, found 1
tree backref 1619623936 parent 267 root 267 not found in extent tree
backref 1619623936 root 351 not referenced back 0x55c07ceb0350
incorrect global backref count on 1619623936 found 2 wanted 1
backpointer mismatch on [1619623936 16384]
tree backref 1619640320 parent 267 root 267 not found in extent tree
backref 1619640320 root 24843 not referenced back 0x55c07ceb0450
incorrect global backref count on 1619640320 found 2 wanted 1
backpointer mismatch on [1619640320 16384]
ref mismatch on [17392717824 69632] extent item 816043786241, found 1
data backref 17392717824 root 267 owner 671118 offset 0 num_refs 0 not 
found in extent tree
incorrect local backref count on 17392717824 root 267 owner 671118 
offset 0 found 1 wanted 0 back 0x55c07fce2940
incorrect local backref count on 17392717824 root 16777483 owner 671118 
offset 3456106496 found 0 wanted 1 back 0x55c07b34e840
backref disk bytenr does not match extent record, bytenr=17392717824, 
ref bytenr=0
backpointer mismatch on [17392717824 69632]
incorrect local backref count on 17392787456 root 263 owner 562554 
offset 0 found 1 wanted 0 back 0x55c07b34e970
backpointer mismatch on [17392787456 12288]
data backref 17772953600 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17772953600 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07b3498b0
incorrect local backref count on 17772953600 root 267 owner 317811 
offset 0 found 0 wanted 1 back 0x55c07b3cef40
backref disk bytenr does not match extent record, bytenr=17772953600, 
ref bytenr=0
backpointer mismatch on [17772953600 24576]
data backref 17772978176 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17772978176 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07b9bad50
incorrect local backref count on 17772978176 root 267 owner 317812 
offset 0 found 0 wanted 1 back 0x55c07b3cf070
backref disk bytenr does not match extent record, bytenr=17772978176, 
ref bytenr=0
backpointer mismatch on [17772978176 4096]
data backref 17772982272 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17772982272 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07b9bba60
incorrect local backref count on 17772982272 root 267 owner 317814 
offset 0 found 0 wanted 1 back 0x55c07b3cf1a0
backref disk bytenr does not match extent record, bytenr=17772982272, 
ref bytenr=0
backpointer mismatch on [17772982272 24576]
data backref 17773006848 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773006848 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07ee18a50
incorrect local backref count on 17773006848 root 267 owner 317816 
offset 0 found 0 wanted 1 back 0x55c07b3cf2d0
backref disk bytenr does not match extent record, bytenr=17773006848, 
ref bytenr=0
backpointer mismatch on [17773006848 4096]
data backref 17773010944 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773010944 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07b9bb210
incorrect local backref count on 17773010944 root 267 owner 317817 
offset 0 found 0 wanted 1 back 0x55c07b3cf400
backref disk bytenr does not match extent record, bytenr=17773010944, 
ref bytenr=0
backpointer mismatch on [17773010944 8192]
data backref 17773019136 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773019136 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07b9bbcc0
incorrect local backref count on 17773019136 root 267 owner 317818 
offset 0 found 0 wanted 1 back 0x55c07b3cf530
backref disk bytenr does not match extent record, bytenr=17773019136, 
ref bytenr=0
backpointer mismatch on [17773019136 8192]
data backref 17773027328 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773027328 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07b9bb930
incorrect local backref count on 17773027328 root 267 owner 317819 
offset 0 found 0 wanted 1 back 0x55c07b3cf660
backref disk bytenr does not match extent record, bytenr=17773027328, 
ref bytenr=0
backpointer mismatch on [17773027328 12288]
data backref 17773039616 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773039616 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c080780560
incorrect local backref count on 17773039616 root 267 owner 317820 
offset 0 found 0 wanted 1 back 0x55c07b3cf790
backref disk bytenr does not match extent record, bytenr=17773039616, 
ref bytenr=0
backpointer mismatch on [17773039616 8192]
data backref 17773047808 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773047808 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c07fd61bd0
incorrect local backref count on 17773047808 root 267 owner 317821 
offset 0 found 0 wanted 1 back 0x55c07b3cf8c0
backref disk bytenr does not match extent record, bytenr=17773047808, 
ref bytenr=0
backpointer mismatch on [17773047808 4096]
data backref 17773051904 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773051904 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c080f802d0
incorrect local backref count on 17773051904 root 267 owner 317822 
offset 0 found 0 wanted 1 back 0x55c07b3cf9f0
backref disk bytenr does not match extent record, bytenr=17773051904, 
ref bytenr=0
backpointer mismatch on [17773051904 8192]
data backref 17773060096 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773060096 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c0792af0d0
incorrect local backref count on 17773060096 root 267 owner 317823 
offset 0 found 0 wanted 1 back 0x55c07b3cfb20
backref disk bytenr does not match extent record, bytenr=17773060096, 
ref bytenr=0
backpointer mismatch on [17773060096 8192]
data backref 17773068288 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773068288 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c0792ae430
incorrect local backref count on 17773068288 root 267 owner 317824 
offset 0 found 0 wanted 1 back 0x55c07b3cfc50
backref disk bytenr does not match extent record, bytenr=17773068288, 
ref bytenr=0
backpointer mismatch on [17773068288 4096]
data backref 17773072384 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773072384 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c08076c710
incorrect local backref count on 17773072384 root 267 owner 317825 
offset 0 found 0 wanted 1 back 0x55c07b3cfd80
backref disk bytenr does not match extent record, bytenr=17773072384, 
ref bytenr=0
backpointer mismatch on [17773072384 4096]
data backref 17773076480 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773076480 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c0792b0490
incorrect local backref count on 17773076480 root 267 owner 317827 
offset 0 found 0 wanted 1 back 0x55c07b3cfeb0
backref disk bytenr does not match extent record, bytenr=17773076480, 
ref bytenr=0
backpointer mismatch on [17773076480 8192]
data backref 17773084672 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773084672 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c0792b3eb0
incorrect local backref count on 17773084672 root 267 owner 317828 
offset 0 found 0 wanted 1 back 0x55c07b3cffe0
backref disk bytenr does not match extent record, bytenr=17773084672, 
ref bytenr=0
backpointer mismatch on [17773084672 12288]
data backref 17773096960 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773096960 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x55c0792acf30
incorrect local backref count on 17773096960 root 267 owner 317829 
offset 0 found 0 wanted 1 back 0x55c07b3d0110
backref disk bytenr does not match extent record, bytenr=17773096960, 
ref bytenr=0
backpointer mismatch on [17773096960 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
warning line 3495
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 27741847552 bytes used, error(s) found
total csum bytes: 22551584
total tree bytes: 619544576
total fs tree bytes: 543129600
total extent tree bytes: 44253184
btree space waste bytes: 114922539
file data blocks allocated: 34178977792
referenced 26964791296
andromeda:~ #






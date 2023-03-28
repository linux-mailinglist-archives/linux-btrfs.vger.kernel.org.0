Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C866CB2E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 02:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC1Aso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 20:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1Asn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 20:48:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520D10CB
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 17:48:42 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1q00Kj2a7J-00J4d6; Tue, 28
 Mar 2023 02:48:33 +0200
Message-ID: <7ec722e8-d685-004c-6c24-6bdac7982e0b@gmx.com>
Date:   Tue, 28 Mar 2023 08:48:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
 <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
 <ZCI0DXvc+h7DoZvB@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read bio
 for scrub
In-Reply-To: <ZCI0DXvc+h7DoZvB@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qs/H7UpQPOoERDNAfO5dih7TJCM6o2KGQvgakN01tGWQpfvvBHo
 +RzhqQS/MZhIa5M94qhJ655IdFNbb+4J/CFxqPBbBBhG7JH+8otqNFU+EEmoxV6InZBkUG8
 DdYHbUxDOkdx3TfbH0oEylB27Gk3Rc2Wv6UYivKfPuH/LkKs+JZFU4AjEA90IxxUtNnYUUB
 yzcC7I7k91qsosoDlctvg==
UI-OutboundReport: notjunk:1;M01:P0:JL2Vs6FfmLg=;iN8zpl1kcSnifYlMDkINs07xb0U
 6eMnIMoIeMsrgCktvgKJxZoiP5cqnxf5A1KVZ30jSN5f7JPdRODueFTFnNHAu2INOlfmDmEiu
 pF6RTkU7cKJgqf4kxU+Sog7TAOuj0yZsA1Zk+qrtQLgmNklqad1fbIxypeExd7lAiNZX7EzQ6
 Fyxvadw0MZidCODdjjk7Cvo7VW+Snrn3H1t1oi6EgLhKhZPweh9q9FKdQIacHjQCPIbNDk9O4
 iq2p+/+XNQAzB7ccIwEhW03zcKmM0F4L2MnGGOf4fQ6QySqbo1G6ilrvo7PcsFDSHPqHoM/Bw
 dYk+BuU9SoN8qjZuwEtz8i1/nGsPn/fRiY1BvulTQwIJ5EhMlIK9WRvd8NkUcOHd9VDDNALeq
 /SdyAc22I/RuHow4ClDnzggac8fEdAAvItrWl8NpJeWnHm6u5a4uO/vkP0m8bQeJFNt24B/p7
 qARIj/Uf45XhVAEY3IQdj1iPm0uajaXZizuUaVURwCfXldngYAJ/rNO0R/EEGSdZLkjq1lR5v
 smNTGYY1uqP77wtvVS9bppiOJ5FCacOYhQd6ikILeCRMbaWq5ENksmlPAvbqShIiU2IlnFSsf
 0mh7izAQVOKJyculf9lLSYZ6D3p3NWO41lZxY+Oe70c8IGut+qoRStmGWJQ20brcfGtm3aKWl
 pZyP1bWW9wwGC+CvbdKcJwEwCAUZ60hjMeklrHhtg4BzVjPI7pdN3RemhzMp+4t10eF8cgsA3
 BxZJpkpA0SHa7cBkEpIu418HD65StM9fZ1enQAHIgyzn/j0ALLMgDIntsmb2tosc1zSGkeItU
 yvvA6eIw5vrS7j3VJVQt/rQjuq8jRqPXF75EUBpTj5OU+ZcW1L1aXGJD5l1siabpmZh0lXUoX
 0/b1NBccyBSvD5HZIbh4iU3ObX+LcoSVRkYfUqW8ActUOt/o+jzkGty0S54dwV9dOPW956Gud
 Mt3+aTDWOiXbfDdw8dH3mexp3D4=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/28 08:25, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 08:16:38AM +0800, Qu Wenruo wrote:
>> For read part, as long as we skip all the csum verification and csum search,
>> it can go the generic helper.
> 
> Yes, and we can just check for bbio->inode to decide that, like you did
> in the earliest versions of the series.
> 
>> But in the future, mostly for the ZNS RST patches, we need special handling
>> for the garbage range.
>>
>> Johannes is already testing his RST branches upon this series, and he is
>> hitting the ASSERT() on the mapped length due to RST changes.
>> In that case, we need to skip certain ranges, and that's specific to scrub
>> usage.
> 
> Can you explain what the issue is here?

The new RST would add a new layer between physical address and logical 
address.

Thus every read would do an extra lookup (almost at extent level), 
that's done in btrfs_map_block().

However the new scrub code introduced a new behavior, which is never 
really utilized by any other code path.
Now scrub would read the full 64K in one go, even this means we can read 
out sectors not utilized by any extent.

The new behavior itself reduces IOPS, thus it should be an overall win.
And for regular devices or non-RST zoned devices, we just read out some 
garbage, and scrub verification code would skip them.

But for RST cases, there would be no mapping for the garbage range, thus 
we need to skip those garbage for RST cases.

The dedicated read helper would provide the location for us to handle 
this RST scrub specific case.

> 
>> The btrfs_submit_bio() would duplicate the writes to all mirrors, which is
>> exactly what I want to avoid for scrub usage.
>> Thus the scrub specific write helper would always map the write to a single
>> stripe, even for RAID56 writes.
> 
> That's basically what btrfs_repair_io_failure does.  Any chance we
> could share the code for those instead of going to back to creating
> multiple code paths for I/O submission?

That sounds like a pretty good candidate to merge.

The core shares the same idea, only the support code is different.

I'm fine merging the core logic, although I believe we still need 
different entrance functions.
(e.g repair is only done for one sector, requires inode/file offset, and 
is done synchronously.)

Thanks,
Qu

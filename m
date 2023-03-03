Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC596AA541
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 00:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjCCXDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 18:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCCXDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 18:03:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B68B521D5
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 15:03:25 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4JmN-1pYVXk2RRR-000KxU; Sat, 04
 Mar 2023 00:03:06 +0100
Message-ID: <2ace5cfb-afed-87a7-22d8-8f98a49c39b1@gmx.com>
Date:   Sat, 4 Mar 2023 07:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <ZACrzUh82/9HPDV2@infradead.org>
 <cb26ea54-a0b8-2102-6899-521ca8028b9c@gmx.com>
 <ZAIA+a6G8kd2I8Pp@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZAIA+a6G8kd2I8Pp@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VIq02A2BkPVxoxXKBOsmdC3fyNFQyVCR+zaH04iT0gxJncLTOS0
 3fbUZOkd5eDlgQF//k0S2UQg4Gc2HjpGz/58gwE08TKuCO1DmZuGF6qZcmDe8Ytbb3W8GEL
 KHlYZBssyPpJy8vnU7uN3rRIW65T+k6Hbh4SJTq3smHqtmtF3y1AzWvClSLqIpsApm/wWct
 pNxLI5LBAijst1DrP61sg==
UI-OutboundReport: notjunk:1;M01:P0:NjRWAQ6bvtg=;sBqM1rUJf/3Z42ZCn3qATsxRlSj
 0KNAIOfTFJqYmnnVfRZ2OWIYQK0cRExtKoaeyxZJuUS9vSBBfub4PFUFWDfM3IwcvKRpw9KLy
 /G64JURv8JpBgwwfzvo+HUi7b+UXTd3z50+FobgtI/DC/cuMV6r0hTIz9aZnN9SM9nCeDz9nf
 vmGG9VX3gjtdCXDvc+apmr1U5mB40z77ZpISym3E/VoP90Uo4uUNK/QA5u/v3nk/0Tlesh8+J
 lclFG6kNSjICf+djhwqPOezvP2o1ugNmhHpn8Z0duckK8ubRwdGvu08CbIxmwQJTcMLhbn2EZ
 Vk6jGhG6wFDJWJ3j/GAaFxo8JrbxPJNBXytX2qQyp69Rg6G+jpaN1+X7pOFwkc99V3yWV+FvN
 Ao1mhX1mBwbh38C/dvc6JyRIYJxvTHGpXnXttc7Bnu2qzfo6bqgP2h5UYqcCFOpL3zE6YTi+R
 qUJPFGZTQ8tlrijoz9lYCEhXri34qkN2nKb2LtBiTaJ6GV/JegeLr2/Vwy/o4hQM3ayd8BTu/
 yPebxcG/1uX7hUMPa53ncJ3mGu5wAF7FCNgSxXrnRWwZpkaMRnOMxWkhs6HOTmoKbQRQCwGHc
 +HNYEk9/vtVARIiixfeQ4qpVwzKcADs5V/KcAaTu9IM0/67uA0UkeE0OiEbBC1RmujdYUvLBT
 nvHrC2tcTORN+omHzH0pYevQL8dXGd56AxjomhZoDJ6kcfLh+eJMjhDSM1guNrgC4Yy/fTaBT
 /cy8NfxwfYBvjVrW4Rj1nnD7QvlYTJUO9tzy4FC1+sBmxPmCOl+/Nwkvfkegg8gtXpZzSKlTr
 l/+nR5G5E0KZInRP0yqRMkUb+WOEk+OAHxM0IpnXXJbz78r90EWxLTNlb7z8y6REM0gEHntwp
 R41xRlazlj1+cwtdfYV+FdmClBO0Xfj0hI0lM8Ho0kfRSegYZt5/uCa11hGFplQy1DMCEFE4+
 XTzhAzH+3YB+R1xB7474VVdl3n8=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/3 22:15, Christoph Hellwig wrote:
> On Fri, Mar 03, 2023 at 08:13:23AM +0800, Qu Wenruo wrote:
>>> I have a series in my queue the limits every btrfs_bio (and thus bioc)
>>> to a single ordered_extent.  The bio spanning ordered_extents is a very
>>> strange corner case that rarely happens but causes a lot of problems.
>>
>> Really?
>>
>> A not-so-large write (e.g. 4MiB) for RAID0 (64K stripe len) can easily lead
>> to that situation.
>>
>> If we really split ordered extents to that stripe len, it can cause a lot of
>> small file extents thus bloat the size of subvolume trees.
> 
> I might have been a little more clear in my wording.
> 
> This is talking about the btrfs_bio submitted by the upper layers using
> btrfs_submit_bio, not the ones split out by it at the extent boundaries.

Oh, that indeed solves most of the common cases.

But I'm not familiar enough on the direct IO front, IIRC we have some 
recent bugs related to page faulting during a larger direct IO write.

Not sure if that would affect the use case.

Thanks,
Qu

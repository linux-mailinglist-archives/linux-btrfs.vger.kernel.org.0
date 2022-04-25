Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02CD50DED6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiDYLe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiDYLeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:34:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D45FAC
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650886273;
        bh=ecz/tptLQJuf5zCovmI6o0yig/uGhKdO8FBnbCOsnjg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HNlI2IlhfFPeVNJ9QYVFFt2yMWRDOkfO77jUjguM8dZ0qjpHdd2IabXTmti29q2N9
         e83NP00Vn2nSpdxXER1UvzBchHAnkctFIKNX/RWBfUwhN5H+YONUVAJ5SB2j8oqMyu
         NPGSP0oHVXXYDx/GXnwVYdhO3oSloggTBvfXk9V8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3DO3-1nkKVx2Syb-003d1z; Mon, 25
 Apr 2022 13:31:13 +0200
Message-ID: <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com>
Date:   Mon, 25 Apr 2022 19:31:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-4-hch@lst.de>
 <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
 <20220425091920.GC16446@lst.de>
 <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
 <20220425110928.GA24430@lst.de>
 <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com>
 <20220425111925.GA25233@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425111925.GA25233@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nic5kEKqRWTBf6TH7DuNmE4njHgOtyIX29wV6432v/p6CD1V5TO
 2DBtcCWYh6xCFlsL9iYZqwpdXR0dAQRsv9QLTNnBett9H6IRHVmd6/dOW5zSd23PEePJbAw
 W7MXnYGj8fZuB1TcZBRGy6gr4AWvQy2N6AH6RhdHLNYPO9amTBMRSaaofZScLupydLlcMj3
 lV+LLE629+4LyFSy/8KKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:foCL32I7N5g=:sKMJvfZtH5APeIrhW6Z5FC
 8i7OevzqBpkbvZ/gDxNav9nRpYfyDlfeCUsUsH8S7kyErGaD33Lt1wW+FrObusLmn6P5YLtiH
 Fv7xVdGQv9+VozQVVhyTdSz1NnCl3ujphEO/bY/J9tPEJoB7KKL2j9X7N/o+CE4kNkPDXA+wH
 HjiQtmvAih7O/3afr/lnkMMDx3iGBnzQyocxFPaiBQ5YyrD0Oi0C0yNHaGgDk6HSyWlkvLTjk
 jFTUVeLjPLNFGZUxnNp1afR1puWtlvZ7THYm117rMampAR5hyqPqvMg+uHPXpx/eMNP3EaJq6
 5OWq9WlxUnXXOGX7t5LLRjTbflUwANZjXxhrYi0AaJl/MCIMhhkR6wiKRQWj5Mo1LcjLCc1be
 wZSqZz7HqdmPD9eD8Dd+o4v7pv6SGvXifo4p2QhSIkbJyfiFOEN+INSD1gKPIWraXDWNWloAX
 ZwR0zOYkKqKkQzNiPuphyDc1/SktOrzrwpBqJ4OBAPaPqT4b7DL2z+Kt1Ezr2XEiSlYB2KWIJ
 n7hLo9GQTunKzMNJWZRSsFxCBDuem6X/dJuI/gW8JoUBqVQDFlvPOSHVsVIoQlh1BoBVVht/t
 3+dpXrtBinsp7yxFp5xzLjOGbwyenJk+IE78sIPz78C+vAxWojkxfSywqiyEiy1LS3qzygRWd
 7fqzpHW8YwBh7oHS5T8XK27FHhUXEgS97ywr9/gZpQcJr9yjurG4z323MkC0BalaS/GBqOTTl
 t9hex1K4MMVZfTyc+y9U3X9bKkX25E/d+LyZBwXcFyZkFv6r9l/5/gDlhYJrn5YGI2VX62yfR
 oRTUIJCoI5WZhDC4usrBSpKXZCqT1D/DQs3IFmMkpihjFjnEbrBAeOzbhS3AH3MyRYC5FFuMv
 1WBphH4uCyi//mPJxX9UPRhNtDbKUu4GNS4BRh0VGwcTXdO51OGr3FsyUmX24OYRkRbRxU3mM
 WAy6NRSpcjGWsvTcKPcSRqVFlp/0hx8sjvD5RwuHfQiWHMCr8dCHEYokhbsHOk8d3hTMiEQye
 58MDUk3qjQtDCGpGCkWPOYq/GdOmUyMA2lXPf6oRmBqQQBiznd9alxUFaXw2RLwG46f6VULX5
 sgY7/Z3p1fLgOc=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 19:19, Christoph Hellwig wrote:
> On Mon, Apr 25, 2022 at 07:16:21PM +0800, Qu Wenruo wrote:
>> I'm wondering how would you iterate the bvec of a cloned bio then.
>
> We just stop doing that.  All iteration should be on the originally
> constructed bio.  I've fixed the two places that are doing that right
> in work in progress patches.

Then it comes against the btrfs read time repair.

Currently we split bio to make sure we never need to split bio at
btrfs_map_bio() time.

But this is against common layer separation.

And we really want the ability to read a partially corrupted bio (some
part matches csum, some doesn't), no matter if the bio is cloned or not.

Especially, we already have cloned bio which needs repair (for dio).

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713150DCF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiDYJmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbiDYJmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:42:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E125C63
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650879466;
        bh=y8NsBqqYmegCLU9vBcaN8MqLAlV0mHTgvo1/VMKsTG8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jkyksIEuMXhR0IR6nbBf6erpM4NkQzl/xdtv1Zn1ePvnm5UuGltId8LFv+kNh2bvz
         L0EfW4VLDqNzAL6z/kiW2ZlnUrRGlvx8igX/bbCCsfLb+Uwjzw8XqVtt0MDQJhgtEB
         CsRAk7tFD86IjaSJj+lWEWRygePV/V8BJHXcNO+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQe5k-1nU1Rn0QvW-00NlUi; Mon, 25
 Apr 2022 11:37:45 +0200
Message-ID: <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
Date:   Mon, 25 Apr 2022 17:37:40 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425091920.GC16446@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T7TbbT7xkpbKF0Wx3Zav8IvC6rKNHVFnrVrmNwIYYFjPVhOa2c7
 BrdL8lKF41a+vKWTYr/RWz1FpWdGL1/pBJApaMKv+7qpoC8+YnIRz6rJpAMlFenSJmjhKfd
 1S+I8b4Ere9hVWwW+SmNNfYpz633ffZ02xit5jFtfBkBOic6Kiaz9MAlwVAZ1xcfqHrgmYE
 dWvdyyeCsBEKgE2cE+BIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vdMBjJg0PSA=:JwDw6ErJ728gPRi24rp4Gj
 3jHXa30t56q0pAbSSc5Yb3lg20thEhbdDR1HS9W6YvsRPv+o3OX07IWexYUKTqbr/Ye9CJtqO
 tahjOjpK1XhpgnKvKf6fNwyK8zDR3IGhIqf0ThJ9/2jopdtcH5jCktib3Hx63YTBgGbloAM+Y
 pykU24wYMD92nAd2cdUDCBITABkh3mTk77QzeF9//yswrC+0EhrZW728kAOeG/vjkbrBsTKhK
 xKPPJXLvKHgcY1rvCieHReeLEitS1IH5HJL+Ql/sSNAXh2yawv8a673/MjKhBHna5ACwM2myT
 E6PwGWSiJUhRpziyQRUuiOFZG7v8VPyhYoOgQMIr+tTXAxBbCQgzH7nJKKSu676nDBtGDOBSJ
 RgDJT3nW1xWxVUOeovCqorQbYcUoLy6pq/rw5UF+22Y6ZpmAzr+Z+1WqKTbHToJFittjpevQx
 5AQ/Q4VRnJrgWtGZ4NR6DDLeDymeNgpNz4WHbZ9XSqubT0XritTHWpbyfdJuOd30IgodHCSq0
 KezBmBdmSQcXL/F2LydRqQV2Py0cWFtq96Wu+fUsyEfu0JWcR6yckCmBCkDZvYPvY0R04DeZl
 W3e73twrN293X1/daQTL6kYGO1+nV8T1vP/s5wG6Ikl5n5NSBoqjtzce49cuNkdL7gjKkQ/Ee
 0lR/yigprWOq+Rrxi2sb3BWPMQw6fxwCoq9HHbWTfk8eUmWypHl4hO1y1xMLP09jGJuM4H/L2
 7szmsdCUaKQYCK9hS02Qfl8f/YJp9JktJ0GWoA8E99LjGmThC9j6tu2eLtv6aAjbY+Daq618v
 BRpyT3Spcdpn30JE3UbXqzr5gF88SzD31ydiZEO7vOfpDsdqQxKDH16/AUk1XQv+sSc9ZempY
 ChJKqMkY7NLr4P4QQ8zr9o631e28XFyahA4fXcVFEfaZd6X3dEi3SjXWOXMQp/iPLTMRXUbU3
 15hpRpQ2/Pvg1w1ebvNvexlCXhyOmteZqZ1PF4vMnAQpexELHxgcZUh5X3US1O183xP4IzQ4x
 /XYI5Mgm879ULk4Dcv/BbgFkLnpUcvA9sWdmEOt3ltQRvaan0edC+Otoa8iaXmMNLB8wNOd+i
 BCEgEiWGhAYWiE=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 17:19, Christoph Hellwig wrote:
> On Mon, Apr 25, 2022 at 05:11:15PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/4/25 15:54, Christoph Hellwig wrote:
>>> Split btrfs_submit_data_bio into one helper for reads and one for writ=
es.
>>
>> If we're splitting the bio mapping, wouldn't it be better to split by
>> read/write first, then by data/meta?
>>
>> Especially for all read bios, we use workqueue to defer to a less stric=
t
>> context, which is unrelated to data/metadata.
>
> Splitting the read vs write handling entirely and not allocating a
> btrfs_bio for writes will be the next series after this one.  You're
> getting ahead of me :)

Oh, please don't completely get rid of btrfs_bio, even just for writes.

The btrfs_bio::iter is pretty important for us to grab the original
logical bytenr of a bio.
As bio::bi_iter can be modified by lower level (does dm modifies it
too?), or btrfs itself.

In fact, my incoming updated btrfs repair repair code heavily rely on
btrfs_bio::iter, both read and write, to grab the original logical
bytenr of the bio.

Thanks,
Qu

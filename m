Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7522B5295FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 02:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiEQA1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiEQA13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 20:27:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA092E6A7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652747243;
        bh=qh5xa5xzyHTBihJw2KIx2Yzz1pqAHBGDEp3OlDExmmk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ac5prouBwzerv4cDpaqV0MCP75zkTkQGtuTHkuzRP97HwEIDFLv/W7qgRbiwo5NK2
         qfJ9gtMxDmFS2bGvTlHGyzdUr83Ya3hlbujRkWNHfL0GJA6JlouvF8r8qsXa8bgFZJ
         pL0rphrH+fwJWIsgTm6TY+rISmVSWU3WCrJHSR14=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1oFRqe1DHK-00PtEj; Tue, 17
 May 2022 02:27:23 +0200
Message-ID: <6f64a575-2dec-78e8-51a6-009ea99a27d4@gmx.com>
Date:   Tue, 17 May 2022 08:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: prevent remounting to v1 space cache for subpage
 mount
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1e09cf20ca9309f2b9daf57136c3e2c1b22f94f6.1652682383.git.wqu@suse.com>
 <YoJoIeDHKTOKljfv@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YoJoIeDHKTOKljfv@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YgUJNA9wDE04NhKzylzO3sUForzrMSuK0PYkDlOPEUKG7FuXcQJ
 XgWfMMPGLwhkT/uiHVonfNQ6ajaGlChzYgbyyA+sDFDnHFpIOZQWYs00vJ18tsosLano0W0
 ZIt1XCcvq1wDC/YLLxL0Gk8ZuM3pGQy2ZokdUQ/4LItnDXdkhdDA/AmoVVCGf+puPpbPR+n
 vgqKmHcF33agU9TGKN/Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:67Tc/qO+HY8=:EZImp8G5KBZEIm2HdqNOCT
 Fs32N3HqChKzGwHTZmDmEZblYifNoDVZnK0UNqsyUHXyZwDweIs5s1pNDsDfP6HSLUNlVaY8X
 1Z9JQ1XBjdeRuMD8hZaY27HDHjc9TO+wAnEL9E6PIKph60SjOuEvf9I57taum088JxzSLTedX
 E9COmckSE2mC4nTIFQktqhEHYbgn8z7FEY5adpGu1oGeraUbjaxRV1kAQM4tyqJ/LCjFERsKk
 x9XzSoILC4huPgJEUWoK80gN4SIpUkZ49BY8PVRmCxo1ab+1QkZnsNcFGkwdGf5O+A0i5ZFa9
 Ow47d3E0x2OOzBLs+MB2NdBV0na6kwi1Gu0Z1L0ObMOnIYqRFgi5RD/jo0y1YQ1MgquTF+c5V
 YXMQNCCkPxc1GeT5JUeU6t9x4mH3CjY1Z2x5duQZN6R284vAVUwR8vzGFP6134KWZdCvKHCEb
 7Mpjmno6qg4a0YmAFYcaVxAdp3VxOc+FJvvouT32v61PtgnY3XS26SAdfbRq7YoSGsbWoVWPy
 wxmzkc1MY7mHKvag3HbegXYXZYho2fDMUk/xw9Ca1e78qiqO6r8tsmB7Mc49B4Ymmh9+txc06
 tpoC1bxGlJgVJX5rb5MSyzUs0kxBziThCkAso/ysuN6+jFS3vSiKKbjOcSjUT0z1pPlrfMYoy
 LKa/po2iMue4tJMLYeg0jL/a4+cJ4c92GV2KH0vwMLVRiunrYX1qQPXR8NoBevf4QFEQ6kHGk
 qt4XWTHdP1jOR5mooIn3REGMo+H25mHzk5v72XCWi104NNG68PTKBvT/83KT8MaL13kTzCoip
 N7kZ5MSYXjAApXjwQSaA090la0Wc57tXelbNs6/pJZmEmVUsEto5ArSpc8ZNf68xZGacS/Buw
 TTkzbxapM0bPEEbWJ1Mjmj19+myHgy/Cln6H8ta8OUZQFCZPEglCLMswxFEzn2Wz4UB2LpM/p
 s3YZOhoIPB7aiXuw5QNxkDuGkWja04ULIEfFSqSxu45H5AyAfan1m9hJFiZEYz22fQkQ8cXog
 MgqabwbZjMCUH7tCRVTlP4i3+555roNqUYlm9JK5SuqeTrsvCAySlvut7xQ9/RDPG5kaeL/uh
 Ujn03+q608HbOSk/Qn+m0Bale6CmrcIWz8q4U+Sbb8AkHSTAljpvIntQQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/16 23:05, Josef Bacik wrote:
> On Mon, May 16, 2022 at 02:26:53PM +0800, Qu Wenruo wrote:
>> Upstream commit 9f73f1aef98b ("btrfs: force v2 space cache usage for
>> subpage mount") forces subpage mount to use v2 cache, to avoid
>> deprecated v1 cache which doesn't support subpage properly.
>>
>> But there is a loophole that user can still remount to v1 cache.
>>
>> The existing check will only give users a warning, but not really
>> prevents the users to do the remount.
>>
>> Although remounting to v1 will not cause any problems since the v1 cach=
e
>> will always be marked invalid when mounted with a different page size,
>> it's still better to prevent v1 cache at all for subpage mounts.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/super.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index b1fdc6a26c76..1617528a3367 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1985,6 +1985,14 @@ static int btrfs_remount(struct super_block *sb,=
 int *flags, char *data)
>>   	if (ret)
>>   		goto restore;
>>
>> +	/* V1 cache is not supported for subpage mount. */
>> +	if (fs_info->sectorsize < PAGE_SIZE &&
>> +	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
>> +		btrfs_warn(fs_info,
>> +	"v1 space cache is not supported for page size %lu with sectorsize %u=
",
>> +			   PAGE_SIZE, fs_info->sectorsize);
>
> Shouldn't we be doing ret =3D -EINVAL; here?  Thanks,
>
> Josef

Oh, forgot that.

Thanks for catching it,
Qu

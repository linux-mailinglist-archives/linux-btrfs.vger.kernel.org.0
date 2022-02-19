Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659C44BC37B
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 01:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiBSAem (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 19:34:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 19:34:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050D177E76
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 16:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645230859;
        bh=AgKtw8bQlj5GMsj3iFnZljrW1Ck/vY3u175DAvxl3xc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ijUnT9OvO9RwCX2e/IlaRPg5rl+8yTLdvrms1i0MFYdy8LX+76o6AY/WUicUa2FbZ
         a5dSJyI60bF0UwSl1iqA7ncrj4dkHwj/RX3yUmZ/WcBcymBNCckda1gLg/n7AURjlM
         5Db4X6ev9hNhzDtKvT2c7SabJwydxsonRUveyB1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwQXH-1oDbNH1dHJ-00sLds; Sat, 19
 Feb 2022 01:34:19 +0100
Message-ID: <8616b8f4-1c62-eb3c-d497-aa826b6c1f78@gmx.com>
Date:   Sat, 19 Feb 2022 08:34:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] btrfs: subpage: fix a wrong check on subpage->writers
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <486801f8e45849c882c2531fe72b6a120429be07.1645150277.git.wqu@suse.com>
 <20220218165721.GD12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220218165721.GD12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J21JJ/qLse60YsvjDdMyaJnd3zOIxkHmUwhRM7elkHVx2aVkhsk
 q7SpAszIqh4yO30XLQURCR7amhK8WqzBUFF9BSD2JQHQsrbum5qYSZ/33PW5LGwHrs0188U
 2eHer3LSWKNS8i44Ta0UZhclNPDu9Pnm09gTKld4Oey+n3S5ZmB/QkOlGxwiQ1SqATz0ZYa
 Iorzy8UlfX4uBaneGx0SA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/puK2CPhKHA=:BsMW+tl06ogkeLZhG+B9KB
 4ev7DZQ7QJv7u6GNnacLCV3MauGI00c4eTRb0vEVeETyrAbNFQxApTj4KoVSyVTG4dRIWgZns
 9WJ7sjEGdbizEsXYnb3G7Vr6pd36ZYBx1X5xFHfFRWB5X4Pts75skqXQQZHqR3Jc9Dcf+GbBQ
 mr78Ezu/4AeYQEPpBhdaHs5FKdmolmyRGfxAAOqipCQWnYIxc/NJN2L+EHOmYNFwLAWSrL97E
 QHjo1oUdf20LT1m0HQQydoDQs2CVOD1XdXPLuw1Y8jeHs/3szPy84rho/RHDkfsHsFPw2wW+d
 SvMCQL61Kbv6H9oN+Cm75BszQjg5Zl1xdjkv+X4HoF8ZGIT07e4oGjATZP0ULX/zos6Ls1w2I
 X9FZiHmtUHBhB3u1Tsmy/PdbYRMLEYF+DyTWdZiH+WV6kZ7A9aCY3dZcH+kOXFxCiagPunipQ
 R6fcD7/sazMvhA5PQM7qt8L2W5k1cShpskUJpLYRcR43I96yxBpZyyoNMDY2e3GQcj64IsmLP
 CIqMxPKntJk83I7vWQ0gnByAcAdbTlTde2vG052uxwoRqOHRJLipXala64iLmOBR3gXMkQZPI
 v/R8g5kT9MOI2Q5jJ8Tq5UndPA3CVmMiXgUNAqS3SMiLQMz55xhKbAm5Q+irjsWofYUaUF0uw
 Co8GXPvYWQgaJe+/O6nVPVYI61EOygge/xyuYHi1DNgmw40VNUB+hP2r3GTAINGJUqpaWplHX
 cOE2pw2xnqbgtVpPUMivLnA5871pRAFaTTap5Wjrp4nrTuKJnuFT8fstX85Etwfmpfblps2RP
 k8rahsHWRe1bLv6Bd5HB8Zpwym7BDVVPjQkcfMtZr4apf0LMLBK17xQAW4+npuIH9+UVsrLbj
 XqRZbas1h6Mh4ZBAmAmYEOTqs4n9UcUdn7yPenFyvaQkUHYRTMA4AqD/uDwS4Ata8iaWyrteP
 sDqAkzWrFWTOlRElCQEIPibbycvjmvJCx/I3adRxYiFcb9ikc1HjYFBk10nGiY8ap+TFcuGBl
 v4v2lEqoCWHVXFPEyGQnkDhO0pwv2GNz/0WShJOH2iuJQfuIUSB5KSJnPMZcBRLnvVRSHwYWc
 nnBgE0e6WB7w+Y=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/19 00:57, David Sterba wrote:
> On Fri, Feb 18, 2022 at 10:13:00AM +0800, Qu Wenruo wrote:
>> [BUG]
>> When looping btrfs/074 with 64K page size and 4K sectorsize, there is a=
 low
>> chance (1/50~1/100) to crash with the following ASSERT() triggered in
>> btrfs_subpage_start_writer():
>>
>> 	ret =3D atomic_add_return(nbits, &subpage->writers);
>> 	ASSERT(ret =3D=3D nbits); <<< This one <<<
>>
>> [CAUSE]
>> With more debugging output on the parameters of
>> btrfs_subpage_start_writer(), it shows a very concerning error:
>>
>>    ret=3D29 nbits=3D13 start=3D393216 len=3D53248
>>
>> For @nbits it's correct, but @ret which is the returned value from
>> atomic_add_return(), it's not only larger than nbits, but also larger
>> than max sectors per page value (for 64K page size and 4K sector size,
>> it's 16).
>>
>> This indicates that some call sites are not properly decreasing the val=
ue.
>>
>> And that's exactly the case, in btrfs_page_unlock_writer(), due to the
>> fact that we can have page locked either by lock_page() or
>> process_one_page(), we have to check if the subpage has any writer.
>>
>> If no writers, it's locked by lock_page() and we only need to unlock it=
.
>>
>> But unfortunately the check for the writers are completely opposite:
>>
>> 	if (atomic_read(&subpage->writers))
>> 		/* No writers, locked by plain lock_page() */
>> 		return unlock_page(page);
>>
>> We directly unlock the page if it has writers, which is the completely
>> opposite what we want.
>>
>> Thankfully the affected call site is only limited to
>> extent_write_locked_range(), so it's mostly affecting compressed write.
>>
>> [FIX]
>> Just fix the wrong check condition to fix the bug.
>>
>> Fixes: e55a0de18572 ("btrfs: rework page locking in __extent_writepage(=
)")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to msic-next. Do we want this for stable? I think not as the
> subpage support is not complete.

We want. The subpage support is already working except RAID56.

And this fix is needed for cases where compressed write falls back to
regular cow write.

Thanks,
Qu

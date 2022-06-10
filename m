Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D04546363
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348785AbiFJKSX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbiFJKSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 06:18:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE740930
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654856289;
        bh=PaoKSmpRXRh+S4m1jLNOB5BF7RJmozlfR/RaLAU0nUU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eLRqX6VzVtQzgnzNAwLGYzaFwl2v54YCnHRylAuW1lAbbI+5ZUuq09XFus4bwFCRI
         q2Teyh1UsbhZzhgAo/dJ/nmKpCofH5W/Ei6et7GNbFyhohR0sVQjmknTAcHeVfhEZJ
         dWIQgFR2BliXo+dKQjgiDhwol9LjPBnkZNypEC3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9XF-1nqZI92Lej-0097jM; Fri, 10
 Jun 2022 12:18:09 +0200
Message-ID: <3410bf6b-f5b7-5801-b10c-5e67354e0e40@gmx.com>
Date:   Fri, 10 Jun 2022 18:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: add tracepoints for ordered extents
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
 <2d623799-53ca-7c20-0433-c455683c5e83@gmx.com>
 <PH0PR04MB7416CC44514F9954E39207249BA69@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416CC44514F9954E39207249BA69@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1xun559RNXbpTCWLv3GQx2NfaPiR1YV5XhiLbbTeryJ1Ke5YbdV
 PkqpYzzyP5Pys7w4IGRLbJg2QxDdsi8tNoITBinxKxhYzfxBVjKcFUjXpKLRkzuI8zmrS14
 vJOxh3S3BlwRAmUCNDUCEmwvNKtrWzFNNBrqrpm+na2DorGfeJGsNhDEyFemUVmHPyz4WZQ
 koOF5gonujVutGwotY6/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gI9eE429pos=:68klmIfxdeFGR9/45ns5QJ
 N7AeFasWqr8zkU/szfRFrzsFRLTBSGlf7VdworfERXTMrijkCjV1wV78CQX+wwwmNeK0CC+Wr
 mmd5CrsuYumx0ZU6D+oR/5Y5+Df+HD0hLQSfhowkG8inNfODqOK/XVfIsfZoMHMaOnA31nS28
 rP2RJlPSIfTTa0pCoL4MKaBKcLUdhZFLEgYIUIui4Oz0afpKri+xRMBIa5+jfsdoVc4bfp2QV
 dBXkGnlixtYDxm+22VgCgKK2eccFKztDxGAajKsWsZxnpcRfle8kZQLxXQ2tuAQxzAlxuGhJm
 t8Z23hIsjZrUemwA4C/SA2Arp1xHdUmHkzY1rWBWTMefy3wvO5IKlZVLonPrT/BGAJLC8Uhq6
 Y3m3k2HfsUVoFBYVC+MCN3LR+yo+rwxU9ikqacbx4Yi27+Bp8aehklYHK+AP7HjwJIeASk12g
 sgcXmA1tMnTVE6IwW6PaOEbvaBGHIIL/o45sZURWPr6+/MeqcxrEIaNG+68LhzA0auUT/Pxzw
 ng9y9VDbm6LgWtpmqFhndqbqK2yP3PfSEnjByAXLhHMMKbT3M4CF/f8aw/OS8pk3PfALWIHjZ
 zWnzLsveoei68bhFK/Mwet7hIo1wI9i3lK4J324vvZJzA2rVbWQvdqumgreKCe/5/ejsXwl0i
 Rs8sqSkUvhFBUs1o+YBuTB1sonGoxeCBq6sVPgDvvkElLH/sZ3PjrmphJ9qglWrhdr21H3+Zg
 OS7N9mbkTsDfRN7Rtd3HYR1GJsczkfZWg6wnK1N3fnRSn0/xHzCzZYvXtzK0dHwqSBUsIoI/q
 u5iyX1XgUxSUiapcJUhzJKqufq7ugfuEbCLCQWNckJJVx1R2fqYuIQlQGNqHgGSUj9FqrFATi
 4DZuHY9T8U6tfWyMnpo2VlGM+S34TIdFGJ71qe8fmxCq9fdELPrIcQrWIVkMyUo+ZABOEk+4O
 TX+RGNVq1eKNZ/P2EWZcWWmW8lMQ0YGKqRmaPTwEFULSnMi9FkttvSHEM0yX+xfF2gXFc5emp
 Mq1sTbaFuRaYuFe7I1Tj+i/Q6bsk9A2qJpga3CGQDACvjMJJ0D4wzCiHdlEt5JbJ4+kM5STcH
 8nfUn1FRylss3Fl/iQIz+jXDi6wv8KE5d03GrU/WtiQUQ2xHkNWa+Rj+g==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 18:07, Johannes Thumshirn wrote:
> On 10.06.22 11:17, Qu Wenruo wrote:
>>> +	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
>>
>> I guess this doesn't have all the info for this split event?
>> Like pre/post values?
>>
>> Although we will call clone_ordered_extent() which will call
>> btrfs_add_ordered_extent() and trigger the event for add.
>>
>> It still doesn't really show the pre/post values directly.
>>
>
> Yup, unfortunately you need to do the math on your own.
>
>> Is there better way to just add extra members for the existing trace
>> event class?
>> If not, I guess that's all what we can do right now...
>>
>
> Not that I know of, hence why I had to do it this way.

OK, then it looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

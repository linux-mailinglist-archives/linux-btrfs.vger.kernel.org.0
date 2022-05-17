Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FC529C85
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiEQIbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiEQIbe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:31:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CB5403FF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652776288;
        bh=tGaJ3HcJrRwOnirodXRCKB8yncgYZuj12FIhPS9K8ak=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=PgDP5Q5QkwnJHkArYJgKuiDt77KDwxD7S9qJL1SrCSkQo6XDiVs6jIE7+CzNbNHkh
         OwgQuw4nNiS+OgbWkQgUBjLL6MYB98PcQq4+LbZA3GklqoV1Rq4en/8wB6XDFxXIbw
         8jczNsux6ILeEBL4NAiim3DFuM54iJMzNjIPb0CY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1nIMsD1yly-00b6Yr; Tue, 17
 May 2022 10:31:28 +0200
Message-ID: <e6c62269-4a47-98c2-ce22-52da747b8e57@gmx.com>
Date:   Tue, 17 May 2022 16:31:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <b018704727883c27c3368f1cd3ba84daf682b733.1652711187.git.johannes.thumshirn@wdc.com>
 <d16c5465-2c24-1ce1-9b51-be85cd96259b@gmx.com>
 <PH0PR04MB7416FE34CF8A665F960691179BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <573613d5-156d-fee6-5b96-91ad823364b2@gmx.com>
 <PH0PR04MB74164ADA2B3AE9E749CE78209BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB74164ADA2B3AE9E749CE78209BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xKM1KLYf7Abfvf9Uco5/zaK2ZJf9R5lUsuZ2qIkrEqgvPqtKVIf
 AHRlKzRkj+cY+OMH0bQNIGnjGfpI9vgh3bXtvth55NRHWSuVmSfsMyG8W9dfoju48/Rb2Xv
 Q/a0fhEjtYj94i52LW4iPhjGad1CciRuv/qyRfy9h4Q4DjEnsYbeCuz0RGjk5Nv/ThWisTa
 Ae14VkDXciQPFDKktR0EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dSeLj58VDj4=:WG9ESN4Eo9jXPqG+Zvf1D/
 MV4GHxo5lu0hgsjWCLOHbauBnA/u48Q/i34K4TmprwwyEK17DUXcINds4IPoW8SCyk0WymClU
 f9f1FHm18dId5JNbq8zR+2/59ozfr0aC/0azmEUDt/eL4i1Ny9ZGWpnqFHiXyk0DmR4i4uoBq
 CJ52/H34JN4E0ivtSABJ/9yqNikzFa1WoMTyb33nLeQT9WE4o/zDsVzoCs7hrePJSIisG5eY8
 N31BONfehcm1YaqICe/hDC9ng9X6vrNS/q4vnOnVCR8a1tNyW/GbOd8HfttyfoDFTnsM3WKah
 KgkyfQ0boxdTuvbaPhSWGrLJADHCOAzAC3CVfJ1ZiF3Emj0Q4Kto+xEYCgm3/MQoHD1DSPBaj
 GOeqqofh6XRd+YBVcAPE6I2iR6gj0ACxQp0CS4f8Qqxg4R8W88LuL7IhG4dfgvZcmNeFHFKym
 qSMqXrojXmaFMitQTuaIMPib/42AZWHSk6wvRd4ZfOMLJjhCaC2FqocmVUxQLAwdrjXp9tfCL
 ghVjE8718F/hiYwfiE5YencY5RVJTa8lcM887wZpIchThmiwL740qklVSzYdVaqRI4pQ91TAN
 ONYd5xrYNhOOKYw9ejIW1MsKGAQqUAXRx9c+Tk94fBkeSmDy+wyRiY7grZoRjZCEj95NPQNOD
 aFPSFxCs/R+RbFqSoHGwf48tbA+t7jJwdXXKGgynSI2gIBEUMCAL6e9X/u2lSgaz3TmtQ8rUI
 S70rQUW3D+ubQ7rLbxQKzcsfFqSlaD0x9EvKhCFC2LN+CVVw2HhyHGyD3KilYKB/mPLvqgA8h
 zmZAniFOcm2rJNrA+sDxVcf362TFAPYlGK3SXsui2kVishqcfDQMaX/cQlgOB8FhiqQ4u4o20
 4Dc6LLOtai5FwGoM5AsgPCPZK6qzYjZpgqWR5kqL5+6pPomqCSxAeTuAzYo1GjDmJ2IA3f86o
 cwMgF4kwsIAiKfkj0bnsUUkwW+dMKJQzZef4PejIPJwY/7043nryTD75nINf8iAouNr5G4asF
 D7jyI86bb5/vKB7BdIzhuKbePTdXqS54WNJQeFL5cweyg1QDLFlKvjq8UfgvMIceVoMFqRrsq
 TJYYPnjoQm0hKGaTSURTAA6QnljFeXGOGE0f9H9/aN82usF7YsCmGUZlA==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 16:20, Johannes Thumshirn wrote:
> On 17/05/2022 10:15, Qu Wenruo wrote:
>> But btrfs extents are immortal, it can only get freed when every bytes
>> are no longer referred to.
>>
>> Btrfs_drop_extents() is complex because it's working on file extent
>> level, but __btrfs_free_extent() is already working on extent level.
>>
>> Or do you mean, the raid stripe is not really bounded to extent level,
>> but really bounded to file extent level?
>>
>> Then I'm not sure if it's a good idea to do such level mapping then.
>
> It is bound to the file_extent_item as the extent_item is lacking the
> (logical, lenght) information I need.

Then I guess the it would be way more complex than we though.

For file extent we can split it for things like CoW, and it's really too
flex and too complex to me.

The info of logical and length can still be extracted from from extent
item (of course, or we will have way bigger problems).

Furthermore, if we are bounded to extent item, then we even have the
help from delayed refs update code, to help reduce the IO on stripe tree.

Although all those benefits come from the cost of new creative ways to
pass the stripe mapping info to delayed refs...

Thanks,
Qu

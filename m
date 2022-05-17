Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4717529BCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiEQIJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiEQIJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:09:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BCE3BBDF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652774956;
        bh=MxWbWBDeCNWAkV44qXVWcb85dBLas9xcRUA27utFlc8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=YvTKjmsK6bsLjiDLplsbFRV+nIwdY20LmmiP88Pt8PUsmgQiSAnEegUxFGUYF5Xrh
         ncgdrGw1dOkwg3nQjx+Fn5Yuhe1mgID9YXVtQdwAGUUAIYEfnzj/b2A9Q+WeEVhs44
         cY0uD0W+T3/TCRU2GNkY+4lneoirsJZJAMSMmoDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1nrQlR0o10-001lrT; Tue, 17
 May 2022 10:09:16 +0200
Message-ID: <4a78e691-92c0-b455-c9e0-00c37ec395d6@gmx.com>
Date:   Tue, 17 May 2022 16:09:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 4/8] btrfs: add boilerplate code to insert raid extent
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
 <bc94b2bf-4c29-d436-be18-da4e64f0fc18@gmx.com>
 <PH0PR04MB741629BEB88E574566C653E99BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB741629BEB88E574566C653E99BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JGhIYWf3rUi/Z9Bqe2XC7b4Aq60y/rwaRue1i/YLCmpRrFnsxYe
 dbk8DCKvD7G7W3w84b/ZPi8q2WycZV8M7nx3oOpJYo2thp96OZnCJYm1gtFUTU6Qtbz8Kkm
 ymT1BaJmw6Iv8BQ6enHzqr2KvNyr/elOfgoHYpNz5clb8QrYtMN6QRc7tmSYw0H67Du6Lsv
 sa3/Ii6eHts56KOJ+/k5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mKKRndXRSfQ=:5k0+DpJS7RqA3Pua0TYb8T
 wWQs5KvImKmOVLH+DAgM7urKzRVoVJEUCNAD0/32x514MQaWg3MyAHFBccqodr7H+q4qKDZvN
 KNPnk0yOyU2ru1sEWmklPjwMOTfVHMJcxjG38JCLL4+FDPiGW5/ZV/AZm5fdl1KBXKRkxV41n
 OjteHxO+VlZd3Cq4CMxEWDsOLxFIZZhZf5ErSqE+LtsZhc/+pIE9bilFMREgjemMDjdUKLWFn
 5Um0aE4WTZinzMNL8RDBq5zLfyWJmgqvlTXSHpBcsig7r8ya4mrolQHEP/F7Q8o60551lo241
 k0j8+D2+00wYmnPGXlmnfSxhFW9gKr6OW8+IDbf+hMv8Ev8x06EdYqvSDUE9oAXOlhN02HiIQ
 Ox0QSyKfhbZH4K6vSYx0xK2pFglPs7b96K8RBV0Qlb9W1gaZdm7WnG5QsGmFSKIAONTZOcZIS
 BcLerSanv/2ocf3mpWHk1jmutIka1c4ebgsRUhegK3PRBr04uM/4QSFf98c7bMZ/8QLgUeGyD
 nRmypm5jkfP8UqOVKIcLXSRwA/i31m9xZKIXcM1+Sfgd+jwENVLNv7NQt4vLG00yb9BH9oPvU
 DdwpyqSRnYhXJjj1ZBKuXDkPGSuf+yIuL3VJhI2tfvP1OJ8a8xl7xemreais+/0fuyD6NPn3j
 uFtTH2ZplAzNaaHUakrEHWx8JrH7Nzk4Xm8O5sZ0hv9AQUsCNvd8JpnbEIGlwonerG5e6CUPJ
 eQ196xJlAd+/ZTU7C/EmT+vqpU1G44zp7LQZ+a9iuoPWGwLUfIGFacf+mcecPORmQgAVYd7nl
 Kq4abotihYXWhcJnQSm0fDn14ik8iGHTgXf5y6YzPYQOQUw5d3Eb1+btHPT4qDquWoc6F+D9R
 dvGHfpMiZHQCGflnjPohr/2lBsvDnkxd+T9BxfryMmxNwFj1k4tnCWv+zjGOcsjnzBvgxnERv
 3FFX3CLhOJXJ0dVE+nI4AN04J72eDv9zNHDtANFRdA8yzdTCt1ityCqvxn18cj6jPcfih3RPi
 ov7Ef9HUc0A+Xnka6gG3m0Abe4iGnOIGEL34f2jGg3JtIRqGzRC2nPuRFNOOWiU/VKkgIyLZ0
 BR00jgyMFTAq3HudYZm64C8IglcSIQDrsVW/HfdUMVbHOUFMtUg40hCvw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 16:05, Johannes Thumshirn wrote:
> On 17/05/2022 10:01, Qu Wenruo wrote:
>>> @@ -6700,6 +6713,12 @@ static void btrfs_end_bio(struct bio *bio)
>>>    			 * go over the max number of errors
>>>    			 */
>>>    			bio->bi_status =3D BLK_STS_OK;
>>> +
>>> +			if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE &&
>>> +			    btrfs_need_stripe_tree_update(bioc)) {
>>> +				btrfs_get_bioc(bioc);
>>> +				schedule_work(&bioc->stripe_update_work);
>> Considering the stripe tree should be a 1:1 map for file extents, can't
>> we do it in btrfs_finish_ordered_io()?
>
> Unfortunately not at the moment. I need the stripes[] array from
> btrfs_io_context to record the per-disk physical locations. Another
> possibility would be to lift this array into btrfs_ordered_extent,
> then it can be done in btrfs_finish_ordered_io().

At least to me, lifting it to btrfs_ordered_extent() seems more reasonable=
.

One problem is, if we write the stripe to stripe tree, and a trans
committed, but power loss happened before btrfs_finish_ordered_io().

Then we would have an orphan stripe item in stripe tree I guess.

Then we may later hit EEXIST doing other stripe tree operations.

Thanks,
Qu

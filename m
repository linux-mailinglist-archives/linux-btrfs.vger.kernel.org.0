Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9766C529C21
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiEQIRn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiEQIRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:17:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162514BBBE
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652775303;
        bh=Hd9TJqgSLfPTOgZ6bmjHYfv47vMHus1x7tNaQfc3SsE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CVoxg3uZy5MxRyVzFChfBmeyk2NcHbzxEf2kmlpKGFmF4j1gBDluIjvCoaRR5f/dl
         0Rvk1JxlXpf2KBzNgOWUD1oDVEhYHnpx+llYaeFVdM1aZInGO0xkviHhLhYYjw6gLf
         jEAnPNPfmBNOzRor4obVEbUvxAFjkDzpS5+a5fx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N63Vi-1nokl33mUC-016MP2; Tue, 17
 May 2022 10:15:03 +0200
Message-ID: <573613d5-156d-fee6-5b96-91ad823364b2@gmx.com>
Date:   Tue, 17 May 2022 16:14:56 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416FE34CF8A665F960691179BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GvyHX0bohu0KqASfAds//qQ5oPmwz5GqYTluGVpvHAkzn+LlFwX
 eUARMahG16XXo9VwkDfCGNkg+54B12Rh3rLsZVfNqUYi/j82WmBNzK5LFAmPY9bSc5tWAht
 b9Bn9CBi4as3VB8kXLgAXWs+vjLUPEBxBHToe87pVmpvxz1VmJevnRqag7O7dFetAkgmtMc
 SQObQNhXtBP0FLheUGt+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V/ZWt4BOb7I=:jxLNbM8xD4/EzlDIUO71nJ
 FAZp+611hmflfPjiLH1+TyXUXVZenuJTeWl2XD61JmxFTn7ywcjEkDt7lnlR9RYUWK5hLs11O
 /VP4meE8vMKLlIGaf/zsT4TdhMwaULQuRjRsS2+BK49hZqUEdpXio/Jlls8Wv8A2WcMBOzBpt
 adJJblK8FYlZSxttT3xct74wnUKfEVO8oaC+zSib31UQUc06hOwiGzuGbOIRQlND+yDxlyEPQ
 2xffdAP968x7V/U1aUD8TvHzxIuj9HKQuNUWqMWeqlSiwSgUo6xjKZpADXCWawP+1V4P/Gb7B
 M3dUN024GTr+AwhJS3b0R4k0oKhtKe/cCiYtr/WGgkL35S0Mufk6L6vG74dqk30XpzwfkvasE
 gKckGG2MX69RDAcmcuWtceLzdtoiPs2lNg4KZwkmqEzKUKbIVTA2UVYYB4UrM++xlJCHJXPR0
 G2afwMwpwpK5ih8DxewomOuB6kR1SIAgtIbj0+mlMRQygBQS8y5Ck/PNgVOLL1IH+H21n+9Is
 8FLbq3Ext8AgrVFVE7uJWSlQF1gACrV6GJaqUTgMqHiRtBB0kdkgkkISrXyAUhsF50GwGfmOB
 Ql7PUwSTS+n0x11smUA6Y9MuY171B3WpVjWutLnzrPW+m3h7hNAbIG340oLCHF8oBhrrb8Vti
 pzTVet2l9Ug9A4aZci0gplctiMLaE80knxLTkFh8+GXjBdb6328CqgHA9n/umhNTjheajTeHh
 m2nrWGeRNwsVLJRTL3TpbqWQwdwthA365z2XEd3gpQeIP5ViU9Coa804WyvfBJr+SpPZ6695n
 u5KFbpigBR6DTEsytcG1lKd3ajAJv6MfJQhajRvk85Xxlp8HLMDycmeyFsJlgDA6wIdWJpJUM
 mWVZ2YH/AUQnA7Ezo5hWP/LBIFz0MoVSK/E3pLF1wh5AyCc2LAhjkZnftW9WwH4jQFvaRYez5
 7qK/2170L2XV3tvX5jAwvLKp84dVzuVl6FzXZKaKApX/FW75PBbZiszSRz0d9Ti9yTZuIc59x
 JLm/1nxHFq5YLPRjk4xNG44Uixw9vwjMmPms1vCBqoDK4QyIk6r19p+LR02Apaq2Xro36JHVT
 W8UYx2pHY6uV64=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 16:10, Johannes Thumshirn wrote:
> On 17/05/2022 10:06, Qu Wenruo wrote:
>>> +	ret =3D btrfs_search_slot(trans, stripe_root, &stripe_key, path, -1,=
 1);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +	if (ret =3D=3D 0)
>>> +		goto delete;
>>> +
>>> +	leaf =3D path->nodes[0];
>>> +	slot =3D path->slots[0];
>>> +	btrfs_item_key_to_cpu(leaf, &found_key, slot);
>>> +	found_start =3D found_key.objectid;
>>> +	found_end =3D found_start + found_key.offset;
>>> +
>>> +	/*
>>> +	 * | -- range to drop --|
>>> +	 * | ---------- extent ---------- |
>>> +	 */
>> Thus I believe we don't need those complex checking.
>>
>> The call site has make sure we're the last one owning the file extent,
>> and since raid stripe is 1:1 mapped to the full extent (not just part o=
f
>> a data extent, like btrfs_file_extent_item can do), we should be safe t=
o
>> just do an ASSERT() without the complex split.
>>
>>
>> Thus, I guess to be extra accurate, the 1:1 mapping is between an (data=
)
>> EXTENT_ITEM and a raid stripe?
>
> Unfortunately not, as we can split extents. I've found out the hard way =
that
> we need this. See btrfs_drop_extents() for details.

But btrfs extents are immortal, it can only get freed when every bytes
are no longer referred to.

Btrfs_drop_extents() is complex because it's working on file extent
level, but __btrfs_free_extent() is already working on extent level.

Or do you mean, the raid stripe is not really bounded to extent level,
but really bounded to file extent level?

Then I'm not sure if it's a good idea to do such level mapping then.

Thanks,
Qu

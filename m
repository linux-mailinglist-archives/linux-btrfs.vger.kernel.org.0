Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95F54B049
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiFNMRT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356854AbiFNMQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 08:16:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40214D13
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655208965;
        bh=2Fy2Y7kr+gH6Is72seP5zxdFj9o/bUYKb27pX0omvsU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=cIDSst8u7Xy0qmkqA+kTBVBccHTK1ZLP7qqvJJR337GO/jAkSHiBVT6K8SAVAQeFc
         hf/AlCFgPPkCG2G1Q1xidKlV+NI9uuYvtMHaLiTkg5qQINuk7lF2MU5e3vQ5FnhZ+m
         v1qBrCFvZfQByYjd/AnggfRo3Y/YRRuLIxPatGgw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1np2IK2gkO-00wZOj; Tue, 14
 Jun 2022 14:16:05 +0200
Message-ID: <6b62ea59-02d9-0a0a-11b3-a6bf1c18437d@gmx.com>
Date:   Tue, 14 Jun 2022 20:15:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
 <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
 <20220308161951.GN12643@twin.jikos.cz>
 <PH0PR04MB741601104CC2D56A2EF3C02C9B099@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220309170553.GY12643@twin.jikos.cz>
 <YikapaHhZ41AFcmj@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YikapaHhZ41AFcmj@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzHf8bnnKin7IbeZbyRVpiN37kJfZ8o+d6FMNA9D+j3pFeX4EmT
 w8e9d9+YX/UY47m15kz35b94Fzan88m41TNnM6yRl8kYdcOqelVeG8618CmJwepZglDwVzF
 2LlLY/RTRPtf8LWCFSokFJpQwrPpkpndkSEUdISDYoVplLmVBGdOgfasXlaGPEiAbXZohHX
 K2rswKyhceJM0BelXTn3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x+mYZLE/T0c=:Ps9adwOfgB6egtNRG9LPRn
 hKx7QAJlyQ4LrY+pFUyLWzWBFOHQ8jcF0DoYiMcAB1d7da0KbL6kR3O7zwEER5LmN/XAR6MFs
 sek1CMmUaM+H5t/lpIwkGcrmsI8yjRmSl6x4iIka3Dwl1t+Vw7HZMB6/zbIA1SSEB1RfJL3vo
 PKI22lyfL2rF3mlyT2qdp4EjVDu/6NFGgHWTPB3jPVW71LgUJp5VSs5kID5TkdCkv5Ir1mjN8
 aPIBcDC+bQ5EcZ0qsWH44Mklv39hZDL6mdp9hUW/RwF1GR/qbgqiZMnyuxAM8cXUdw3rKVCvh
 ZPpMLX94VKXUthHNv263IhbTlqbeKifMWoAeyt7nS3vxfft0LtS1wIVAvQXeawgSS+xd4/jtU
 WZiiQjwuE12+9hROW3r1EcGSJscvtg6fvjeXRtRUpMe77gp5jSQQGggwg22azk4gd61yLE9uq
 7jIMOBnVymXXvgmh7Yb4AH5sFLCsFY2PdWWnLSTulx9ycpJ3G1ZecvHmSI8mci95kXyB7yYCf
 +HowU7f1CS3O2roTuCF1qdh8tsCUaetGHqk4cWdTy0Y1fZ3+K3paojRJNKnI41mxFffZ3lChj
 Reu2xitLJbek+RbGCLSlt+IZ7z8gL5yVjrLiOaFTcxoGpkkePsIlE0vjreEP9+YlRNtUAaNpr
 D6OPZiG1LPshyNEN6pQ7mL+jzLlXHUV85lRh3HMBwjxKQJOkBK0KRSmJcnYN+81Y7pfl+BpVG
 T5jvCBU5pJ5vnv37cgVT88qO9mj2mDxr1MY8fkUL0YgTqDHX5BEhcMiHvUlGZYTlCoTDk0ly+
 JJiD8bhbe2xgE9ZTBCQntOadBMExb4/uld4wag1ktZWVa8CQqNdwGDyCgXrBoU+AL5bYtwEl0
 uMVkTf7nPiTiYK8ZirOYW/dCQQFLMMV6upW+wNVJJm8BnzFwogcZcq1lnSjfIL47rQd7k/dws
 riLggVE09X5FemAIps7KTrMe3qWAMZfGAsBWW9LJ68ZdWp8zA6PxncJmIeh0tN13yhqIpfFr+
 pQcTsBT4GITBVzVdHM7Xdn0c+V7DhCslbnU39YTUOF5QI1M7Pbcj0r/N5og4fr0Hat3ivsSDB
 2gc9ml04HJiJkQQLSRhwk439JJRtyhACUE6gYyf0KM6F5ICPftTf4xmGQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/10 05:22, Josef Bacik wrote:
> On Wed, Mar 09, 2022 at 06:05:53PM +0100, David Sterba wrote:
>> On Tue, Mar 08, 2022 at 04:41:44PM +0000, Johannes Thumshirn wrote:
>>> On 08/03/2022 17:23, David Sterba wrote:
>>>>>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
>>>>>
>>>>> +	__le64 nr_global_roots;
>>>>> +
>>>>
>>>> Shouldn't this be added after the last item?
>>>>
>>>>>   	__le64 block_group_root;
>>>>>   	__le64 block_group_root_generation;
>>>>>   	u8 block_group_root_level;
>>>>>
>>>>>   	/* future expansion */
>>>>>   	u8 reserved8[7];
>>>>> -	__le64 reserved[25];
>>>>> +	__le64 reserved[24];
>>>
>>> Or at least inside one of these reserved fields.
>>
>> OTOH, it's still experimental so we don't expect backward compatibility
>> yet so it should be ok to change for now.
>
> I did it this way because it's all still experimental and it makes more =
sense
> for it to be before the new root stuff.  Thanks,

I'd say, please don't.

It's making anyone who want to add a new member in super block miserable.

Everyone is going to add the new member from the reserved members, but
such insert into the existing members are destructive.

Furthermore, if the new member is going to be merged way before extent
tree v2 part, how do we solve the conflicts?

(The new member I want to introduce is just to indicate how many bytes
we have reserved at the beginning of each device, with a new RO compat
flag).

Thanks,
Qu
>
> Josef

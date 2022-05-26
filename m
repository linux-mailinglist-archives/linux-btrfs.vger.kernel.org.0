Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9B534BBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbiEZI0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZI0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 04:26:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E61EAC1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653553593;
        bh=7EsbFwtwX5X6fBeq+x8VDX1sypcsPFB0JE4QNpcRNHs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lhnBTXCOtkdx6fTR3i9FRG682QejFuBSQhHVzI/ybxer7VSQr1oUhzc0lpqtF95WF
         AdQtcmvlX+cqK9mLPJxs96jbToQIWtYxaVXG486H9f9wT8OaLNtUm7J1NzBmCtA0ab
         o0S8GQfGw4tl4CWf9fKthyMtwZeMZ0ufQU6OvAIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeU0k-1nJz8041NE-00aWqh; Thu, 26
 May 2022 10:26:33 +0200
Message-ID: <78c1fb7f-60b7-b8fd-6e3c-c207122863aa@gmx.com>
Date:   Thu, 26 May 2022 16:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1653476251.git.wqu@suse.com>
 <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
 <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com>
 <20220526073022.GA25511@lst.de>
 <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com>
 <20220526074536.GA25911@lst.de>
 <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
 <20220526080056.GA26064@lst.de>
 <0cbbc3aa-a104-3d5e-ad13-a585533c9bcb@suse.com>
 <20220526081757.GA26392@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220526081757.GA26392@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7AunTxxrppsCcbp8F8kIy9qMDn8F3prFen0k45PO+IztnTWxobs
 CYL5FSndiuKmhBHJkl0eYbakeFL2DQjE2i/ZQCD9eIWYP7DR9BgWOrw56fMm6yNW0QzgOWL
 A2YkYjXTARYPCLhbX44vCuw6wbkf8+FQdAQLMjr7SsVGIO+uydacMFQlLOuXr8Awtne/B7p
 pNFIC4nl/2xVOI6zNdfJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XRzH10oGu2w=:/NRxz7Qzi04pT0mSWVJXnn
 dNbSU5dezYqxROPKGjcPYeu+blPtc57c3nljFsFpYdllukMHzDZjG4ZwSjUMZBO1LtKdlr3JS
 qJRlzZ04kdnRiPSs5roBw3VxsVa2JC/yZQLILhUjn50a2ppG0pjvzyEN1d7ce8gqj5bU/dCd6
 CGHn4tXE9sVpOZceKaeHC1J/2Ab5O8FqKyH4EvNtdt4O8SwRMz452XO3z1Dh6OQbp8mU9XG9G
 DVyn9Xl0YVn0+Nh2x+SyQTswY2CVbP+2uZsMVyaf9KKYqp19513KKDb9yrKWSOL/CzGdH12Y6
 TbWWv2SJuwUukWiwTNv05Xbhk3sSH9diQGZ7aa5dmGptW3xeHHMk7wPt4NPuySDiSvz5MdY8i
 zlLbjzm4IqdnXi1g+MOLt78tM+WsdFjL9Lqt2lyCNbjCAe5ez5WdmsjLkRbi+BVu2H+I0/kvs
 5Y1W9neC9/b8VZJ/jL4nktdKtB++1DwoSMPacPi7dy25hghFNRYEuMeVb4RUCvIjhZ3IKuNyC
 FOUUT4zF5pb5VBefz2+z/OD1ySpnE4dw5ZAvRLFRtkddEbxSOzNebNPnEneC7fyNrbBsq87vh
 W91grJsGjN6vHK1RzD/bcRrr1Cx/vvPDhQzEtos31vavZ7NtGsZegnELRTBk+q4RehRhYSO9E
 zraWnwsUsG75zOfVwMI6vzQoHUeB7yxoAs8clm4kuJbqgNHUga+935CD9fyvyETK7C61nr4Si
 PY7apoZsg/VLf1jkLC4qwUpPdx/UZt+AHz4UWo/FSJiIixAQz00vLJ2fKVjXSv/YLZz81Vofu
 JEFSYXQHf3fTN0aQv7cQYqm0n5qXkgnMtg2V+0k9oeb1WbRNErdDZFcSQy1wqqMUcQlWYkDA+
 2GV40lyJkUFTzUkv0oxI95OFOGyHwGD2z7Xp7H5Id2Q+C/W4HG1P6T729/vE36bUazqP7U2Vo
 a1LmG+bfHwPT2Nv8rLXt/P2ifOfS4cFBdxxuJgoHuCnC8V8nYqOS3NJRTEaGKW+lhmO5i5nSg
 mK8yKCXFItopxD1dZHPaUfUF3sr4AA9FtX4BpyriSGbOuahhmFSDLnWZYpY66KxfcRb1JmC6c
 EfRCbrOD9Lb6TzK2sPcgLcRVVgriFXFXXaT7nJaSvjSTq13Jq46/ti4mQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 16:17, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 04:07:49PM +0800, Qu Wenruo wrote:
>> Then it can be said to almost all ENOSPC error handling code.
>
> ENOSPC is a lot more common.

Sorry, I mean ENOMEM.

>
>> It's less than 1% chance, but we spend over 10% code for it.
>>
>> And if you really want to go that path, I see no reason why we didn't g=
o
>> sector-by-sector repair.
>
> Because that really sucks for the case where the whole I/O fails.
> Which is the common failure scenario.

But it's just a performance problem, which is not that critical.

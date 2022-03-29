Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BF4EB733
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiC2XzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 19:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiC2Xyj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 19:54:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3FD237FEC
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648597928;
        bh=meDmwufNaTWblYfEhnvczipaNp2BbrZioEnwhWp5mn0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LtkjkoAYgKU7Ji+6e01HPNmFw+/L7UdJukUIKJ538S/tK1B9nUOR/ajEYcpmHYx6r
         QmsW+QWI112x/28O8p31qj5vM3ft+qFC4Zqpfq6CodmG7C7QGw2qmWX/ZAfKE1KF3M
         HZctcETvHgsadX+5o7SbZMjZSKRmUqgrrQQRSl10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1oGgmz25Ao-00ihA6; Wed, 30
 Mar 2022 01:52:08 +0200
Message-ID: <d7e95b14-1e87-9c09-e172-680d53cb51c5@gmx.com>
Date:   Wed, 30 Mar 2022 07:52:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz> <YkLYJ+xRvmm0yN9Y@debian9.Home>
 <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
 <YkLwAf7SK95iOreD@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YkLwAf7SK95iOreD@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rlgkyfXCdiYF2VoIFPsGxqKCP7kPbGyfu8NbTujVGNNzL1BwVFK
 GYzQUnkBzpCh+Ziy8V+SdHhYPmIMtp8dADySO+KPoe6iWqL2X4nnraaZO0w7Tx64Upqj5/a
 X+4nfbOIYYY8cAECahn8LBfkQTbc3RuLiWmP3IboPRopxy4vNrB3bOEFUXNoo+GW6wUfgES
 4mB7lTx3WAYOdXUmf0m9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N0jrI/rwUMk=:FXxEOUpRkQqzEDIlzzsGlk
 ePVZ4IjY2CrqTWwcbTBulr+ldx0Idxwxv8Y0Lt/I/HGNjk84/ONHo2GQM2FwAyXItfcL8BL48
 tYAB96nb0frS2ZJ0tMfzKO0z3JtbH3SR61UZcyoecZcNQMz3+ZQWEoYMscgBx66Zg2rERhaah
 idDa7U3BJ1hc8C0t7Xi3Tr5PSSKKxO0wrdLaiTYLKHNfry3QQcSJ9ghh22Sy7fjEI6B7Dl+4c
 5RPIHwTIZ3bkTAKcOF6cosGomJkps8q93MMpb91xT9ZWxDoHMz6rAheiK52sIkc2+RRPwWmdo
 7lv3nFMY4KhDhsdUXhaNcnEa4dkAlS4KLBC/ZXeAcm2YkbnxseN817bXBMphJh6QzhejzG8ms
 guJBwNzLIWbcyoZ2eoVTvGGVXL9uBZPg4/al6V+3E4I9tzx/YkZ7GkNqx9h9cPRod5UfeqBEK
 bzdXFQ1bUA7+/KO3SFxp+Jeci1+gy7Y/BhUX1uFsLX/CXOn3LZfYcJJNq0oehWdXOuJQ26ZZ2
 KHotzp2LoXaP6P1dqvKsv87kuiulFZvsftEeUxzRaDLKTTnFD9NahsUivboCNlcDLFIYrxe5A
 2AL2WJdFOyiJXw6HWr54RqSPGpa9Y2cLbF/cPJA8wUdkzsTYaEuloegv+lMxkMzM9E9ZAKrKh
 hpqx+lfFP8hROS5AVfAIqLh9IyGrzCYf/MAXbU4WBpStnPn0QiAMsc/bMuf2w3GPCtz9VhR6Q
 w8gMB7rXo5lCyIOZhnAHLqBTqhWOHvWpb9ao42jsN0sgCd1Oa97BNkPlI44dI8hIUMw8+jTir
 4d84Phv5hTCeDLZrLM1j3kqEIIY1BiBh/dws4v1N3ggilQY9MebQPAfD8r6ln1DoWiMSBWpQ4
 cqhfZUr+bD6NbqTHSVf6VmxjbFVvAkcs1ptvAwquPYVzoNV1MZgGaKIOCZJAZLAp3/OtdGC4j
 Lkl41z3SfdbNBwYHMI645ALJQVm6lieYmN23GAA2o1HgTYcoobcktMYXY7AslSpG9oxEbBgp3
 vTFi1D1yTykRwJ7RfaiBVcuJHOHylPXsxzlMkZ9pYgFYYPJS1YUqpKXponsAc36PDPImpQS06
 fTyTcLOgmwzxwY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/29 19:39, Filipe Manana wrote:
> On Tue, Mar 29, 2022 at 06:49:10PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/3/29 17:57, Filipe Manana wrote:
>>> On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
>>>> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
>>>>> The original code is not really setting the memory to 0x00 but 0x01.
>>>>>
>>>>> To prevent such problem from happening, use memzero_page() instead.
>>>>
>>>> This should at least mention we think that setting it to 0 is right, =
as
>>>> you call it wrong but give no hint why it's thought to be wrong.
>>>
>>> My guess is that something different from zero makes it easier to spot
>>> the problem in user space, as 0 is not uncommon (holes, prealloced ext=
ents)
>>> and may get unnoticed by applications/users.
>>
>> OK, that makes some sense.
>>
>> But shouldn't user space tool get an -EIO directly?
>
> It should.
>
> But even if applications get -EIO, they may often ignore return values.
> It's their fault, but if we can make it less likely that errors are not =
noticed,
> the better. I think we all did often, ignore all or just some return val=
ues
> from read(), write(), open(), etc.
>
> One recent example is the MariaDB case with io-uring. They were reportin=
g
> corruption to the users, but the problem is that didn't properly check
> return values, ignoring partial reads and treating them as success:
>
> https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=3D216582&pag=
e=3Dcom.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#com=
ment-216582
>
> The data was fine, not corrupted, they just didn't deal with partial rea=
ds
> and then read the remaining data when a read returns less data than expe=
cted.

Then can we slightly improve the filling pattern?

Instead of 0x01, introduce some poison value?

And of course, change the lable "zeroit" to something like "poise_it"?

Thanks,
Qu
>
>
>
>>
>> As the corrupted range won't have PageUptodate set anyway.
>>
>> Thanks,
>> Qu
>>>
>>> I don't see a good reason to change this behaviour. Maybe it's just th=
e
>>> label name 'zeroit' that makes it confusing. >
>>>>
>>>>> Since we're here, also make @len const since it's just sectorsize.
>>>>
>>>> Please don't do that, adding const is fine when the line gets touched
>>>> but otherwise adding it to an unrelated fix is not what I want to
>>>> encourage.
>>>

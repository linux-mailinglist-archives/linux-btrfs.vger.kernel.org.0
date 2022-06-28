Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85055D7E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbiF1MoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 08:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiF1MoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 08:44:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D119C25
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656420230;
        bh=oIyz5w0Qq/ZN49jah++J8wNTgX7aSIc99FECoLTXB6M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B5B+YjQ9hUOveQC7rk6QNpsXyJ7mfg6D3J2fYQH8odtFgr/ItnGhKd/OVrC4IsjDq
         JS2U6jib0g51kdwRdqD7K9yy4wgpFQB3lqImL9UZvUATo4rYkAiMkHsoI0imq0ut70
         28KTaemZnd+52nriGytUJJKvM+dby/xxDBYySXh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1oNQCk229T-00IWZ8; Tue, 28
 Jun 2022 14:43:50 +0200
Message-ID: <c267985f-a1c5-5e86-f7b8-9c2f323d5547@gmx.com>
Date:   Tue, 28 Jun 2022 20:43:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 2/8] fs: always get the file size in _fs_read()
Content-Language: en-US
To:     Huang Jianan <jnhuang95@gmail.com>, Qu Wenruo <wqu@suse.com>,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, trini@konsulko.com,
        joaomarcos.costa@bootlin.com, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com
References: <cover.1656401086.git.wqu@suse.com>
 <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
 <6f958407-0c3c-1cd6-ced2-08bc9c267d17@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6f958407-0c3c-1cd6-ced2-08bc9c267d17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zzrt6DchgYRalbPOVLdJYBaixymE0uGIISaZxdxJ3Mtekz3bPmw
 fN3HDLFiGK0L4rbfvBF8e8aFTPf5kn0VvAwx0EECTFFViYeN6Vkn5efSLTHI/wUF0Tnp+th
 +P7Oz5DwsgbIagtxU9a6xIBbPrh/UXG9WjpX36WcE3Vm9uqxkRBVaZzoS5ynGB8Go11rmbF
 DCujOHZQux5PfTamc7UnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:izDxp/J27oE=:b00axej2j5ai9PSWG9kfFP
 3Bl42E7/TVS1v1JHR1EWV1pP71n5QSJ6jUNgsTe5YdgQLUe1+HnluyufjvvJPXni7vfqLO0ou
 /Jdih91WOMysu3dI+nKEFlCD2wlXdbdZoM+IjH+fkuFggEEAQpX/BLFFeZajXbZV8FFd8gpAB
 oV3DAjq19qO1MAgCLzB+RPuVEtot1W3wSp3DSvb80gUiWA3AzEuHr37y4z8Ne29TwMj38/yUQ
 9LkNKlb5XQomlSfLubLm6s06ehmcrwwWAf0ko9R9YkVmT8wTsNaqHi06wlPFAlQBlw4edNvHB
 ir4HQLd/P4ccxgp83bt/L45Vwyo27i2zaPwwNBdllAhMBInya3xYgyS/jbveHXtjVZmQM9Yzw
 1rlSBy8NoJz5P17CGHfgaD+87pa0MxCh67cbdkMXB2xeuYMa01pUamNWeyXoLB65L/hfb/J60
 LJaFJu9BTmPivWIAtj8o6ub5PhoDVkML2gvhV5FFedg5wHAv1BUCsmbV18hnK/ZYGJcP2YHFk
 dUavo23Wk23dqPrEVH0lka/EPvBaVKdsg7poyx6vcIJTgaYdH+lZzVkEnAh08MY93llarzjPD
 0Wthbkiqq+noiKDUNKLzfpNGLUz7nDZ91tXcTrYy8OVLBaN6lSumygjtj2XWTgt/zlk+rVO80
 r0nGsYDy1MVotNMYQxXYVc4xA7aegd6U1Y9AVihL9ZpALiTfepl9Y3A/M9Ur9ysBRmXP91oXO
 sRL+AF4iDulsYSCPm+shWRfg20as1lhn+remrTxS/A73M6HJI3AHJazp8WBzpWSC7O40pcnWG
 hFon09d8aeiFBEbggqHx2TIgobMjijUYImp+VSN9aIhmEpfm4Re+bYSvsCmHJMN8q8GAdTeNd
 xD4OlykhdTU9MkTxrnQ0HXnHT/8Bnixg3NSk4GSlf9Hvk3rK8q56xpU3fBU+YepOZ9XBqJVST
 qyvI8J/Z+IxDyjTEtYbITEdzhkqTUu64csYnELkNoX0UySexFgc7IIF832ZUMIAwq4BvDIDMb
 8ZcxXSgSve5XvyCPvMzcPI3oBYmPLR4C6iyG9wJH5AIheIjtKgSSuNx1BTRbg+hWNRZagslnh
 BbQ1zIpGBxpsEoVC3amjCyCSEYpfWDNnue2l8kab4HAy0ld8PQ6380YOQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/28 20:36, Huang Jianan wrote:
> Hi, wenruo,
>
> =E5=9C=A8 2022/6/28 15:28, Qu Wenruo =E5=86=99=E9=81=93:
>> For _fs_read(), @len =3D=3D 0 means we read the whole file.
>> And we just pass @len =3D=3D 0 to make each filesystem to handle it.
>>
>> In fact we have info->size() call to properly get the filesize.
>>
>> So we can not only call info->size() to grab the file_size for len =3D=
=3D 0
>> case, but also detect invalid @len (e.g. @len > file_size) in advance o=
r
>> truncate @len.
>>
>> This behavior also allows us to handle unaligned better in the incoming
>> patches.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/fs.c | 25 +++++++++++++++++++++----
>> =C2=A0 1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fs.c b/fs/fs.c
>> index 6de1a3eb6d5d..d992cdd6d650 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -579,6 +579,7 @@ static int _fs_read(const char *filename, ulong
>> addr, loff_t offset, loff_t len,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fstype_info *info =3D fs_get_info=
(fs_type);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *buf;
>> +=C2=A0=C2=A0=C2=A0 loff_t file_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 #ifdef CONFIG_LMB
>> @@ -589,10 +590,26 @@ static int _fs_read(const char *filename, ulong
>> addr, loff_t offset, loff_t len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 #endif
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * We don't actually know how many bytes are b=
eing read, since
>> len=3D=3D0
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * means read the whole file.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 ret =3D info->size(filename, &file_size);
>
> I get an error when running the erofs test cases. The return value isn't
> as expected
> when reading symlink file.
> For symlink file, erofs_size will return the size of the symlink itself
> here.

Indeed, this is a problem, in fact I also checked other fses, it looks
like we all just return the inode size for the softlink, thus size()
call can not be relied on for those cases.

While for the read() calls, every fs will do extra resolving for soft
links, thus it doesn't cause problems.


This can still be solved by not calling size() calls at all, and only do
the unaligned read handling for the leading block.

Thank you very much for pointing this bug out, would update the patchset
for that.

Thanks,
Qu
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("** Unable to get f=
ile size for %s, %d **\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 filename, ret);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (offset >=3D file_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "** Invalid offset, offset =
(%llu) >=3D file size (%llu)\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off=
set, file_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0 || offset + len > file_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (len > file_size)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log=
_info(
>> +=C2=A0=C2=A0=C2=A0 "** Truncate read length from %llu to %llu, as file=
 size is %llu
>> **\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 len, file_size, file_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D file_size - offset;
> Then, we will get a wrong len in the case of len=3D=3D0. So I think we n=
eed
> to do something
> extra with the symlink file?
>
> Thanks,
> Jianan
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf =3D map_sysmem(addr, len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D info->read(filename, buf, offset=
, len, actread);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unmap_sysmem(buf);
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FDD58B410
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbiHFGaN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 02:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiHFGaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 02:30:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8213F07
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659767406;
        bh=uMVLBIKeoP03ZgGnQ71EyLPTmA+MF1ZfusXAoVs1hYw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DIPqkVA9pzntHmJ8CfZHLQYgoquVvH2gRXQ0ZpWpZmRrtA75TeMYebHaj78CosEOe
         jGsn6kdLoaAxKftm5FwFlHq+xORSUWrfIb2YQiKeej8FO5ik1Gz+FDjrw+JelGIe6N
         SaSlMvurRjEZXKik6fnCKoLEfZPj0qnXhYjiGbso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1o9nid47D4-00AU59; Sat, 06
 Aug 2022 08:30:06 +0200
Message-ID: <2aee4f0b-9bfd-fd79-c5c4-21733f24a73c@gmx.com>
Date:   Sat, 6 Aug 2022 14:30:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] btrfs: scrub: try to fix super block errors
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <9f95c1c4437371d8ad1b51042e5dc82a5e42449f.1659423009.git.wqu@suse.com>
 <20220803125513.GC13489@twin.jikos.cz>
 <52323456-6820-ce55-101a-8aecc3e73539@gmx.com>
 <20220804130621.GM13489@twin.jikos.cz>
 <7dd7fd85-863a-3c16-16d6-0f4436091d33@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7dd7fd85-863a-3c16-16d6-0f4436091d33@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t+rfxJ5ux3xHOh3pydiglW9H9uPXEMo9REZHtfPcRn0Di8jVhhj
 RVZYVf4QFbw9KUl8MQtqS7fRd9td+BVo3m+/Fh7Mr50wCzO/cMVmO3OwUzOKVRPwPe2yX45
 2C6ar5cc6tsW/4hg0gwZGx8h2jokEvsK9HeAPFOLTzqP6sktIl8gwNpSQoFhoCZETocI45p
 OE7SlDCmZzK79kg3lyV0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z9JWKn/g9Sc=:gnHWMrjtQDMwasuo2ZeWWK
 DeZ4psyjTF0dLs41IcVZLaYVYgbvajRDK7K7oA9kW7gMN/mH0hEdVDlmcJoRArgdHssVGEbV8
 0AJPcfdkUegRku3kJS+lw8hJ7s1aEGntLhrCTRmBjFaCW/hvew37pLDzCPG/9FfTGHUSMQ811
 NqR2pUm38gBmYrAHQHV9NdkqRFNoRQHlTgsO0l/sIaBZtk8o0eYNQliyjD0Qcam5tH8xb83Xl
 Bn9a4/vOzoosdjPx6AONkTVSQNGWGAMdPY22OPn2WpapT981bYfqmdmRkULHCkFnWqFkC6l3f
 ohsFuiAaAWthALAg/e0eNLmVlnj0ixnPoUn59YZpQOkWqaacz16eTkxSmrf+Bvle7ZyXUUzqB
 SL3kc3Dxi6EQySci0Fj6mt8AuXtWoLf1KUMuZXhT7RLW/jAqG8WrBa238aWt9u5b13/uYG8l3
 R9HyF2jDHGK0cvkXzgOGUlC97jM7Duyr4uD94b+92cGPJw1RHOizbwZyqCpHwtzFYuxEw0mKg
 MhDAbYUyP5l1D2XQmlQNKSscG/iFtNTS0GbDM6CTbeK9DwI3MzbeE+teCm594wj+ewXjgM7ex
 bYnkAnoubBpRbeh/aCSOsZgY3cczThbMJBQw7kRgwHFCqHphL43Z1AoX3tfyZC8quAPk3PO+D
 9SN1c8EMq5c7LzJrvS4pjCccDnKA3QdXRlP5RwWe7t4pz3QNQ7rHGs8+boo3/vatVWtGd7UF9
 QOpv1wvgXZC5JYv6VK0XrljuoH5DvTCJmNKFR16LWy9dHxV2jmd1RidvYtXzBq9JSkbwb3XN3
 BsQ2CwHjupU0hwFgT0dob5gauFcn53JrH2P1t1nA2vApSgZzJXZoNMsT348y20ib1vYT7Az/k
 KIRnRSK3OEQiafoG3iPJVC1a/1OK0NFGI5PWvijFEkjxQp+E5gIFb/USH/mtR9mtBnPzmgMLH
 tI7dRTk8/cys5UMZFqwfQ5hQ7n2Za0vmvmeH9debbyXTsf1ig2szBbRGdIPgSG+K77mWT/GXb
 kRtfOq35wCiMorv9AGB5FWA2i4L64cVVI7IRAa0KuoLrG7xPN/s4H/e+RD8RnRrOXQjA1ONyz
 iNk6NHShxrpMVyTCHa3nDPNF6CHYwJXeTr47IS9bqVXN6T1uLfzN385Dg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/6 14:01, Qu Wenruo wrote:
>
>
> On 2022/8/4 21:06, David Sterba wrote:
>> On Thu, Aug 04, 2022 at 05:49:20AM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/8/3 20:55, David Sterba wrote:
>>>> On Tue, Aug 02, 2022 at 02:53:03PM +0800, Qu Wenruo wrote:
>>>>> @@ -4231,6 +4248,26 @@ int btrfs_scrub_dev(struct btrfs_fs_info
>>>>> *fs_info, u64 devid, u64 start,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scrub_workers_put(fs_info);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scrub_put_ctx(sctx);
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We found some super block errors before,=
 now try to force a
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * transaction commit, as all scrub has fin=
ished, we're safe to
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * commit a transaction.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>
>>>> Scrub can be started in read-only mode, which is basicaly report-only
>>>> mode, so forcing the transaction commit should be also skipped. It
>>>> would
>>>> fail with -EROFS right at the beginning of transaction start.
>>>
>>> It's already checked in the code:
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sctx->stat.super_error=
s > old_super_errors &&
>>> !sctx->readonly)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ne=
ed_commit =3D true;
>>
>> Great, I overlooked it and searched only for BTRFS_SCRUB_READONLY.
>
> My bad, I didn't test it with replace group, and it can cause hang in
> btrfs/100.
>
> The cause is, dev-replace will call btrfs_scrub_dev() with extra
> dev-replace related locking.
> However btrfs_commit_transaction() will also need to wait that lock,
> thus we will dead lock there.

Ops, this is not the case, it looks like the discard related bug.

Although dev-replace is holding replace related locks, we should still
be able to commit transaction during dev-replace.

Thus nothing needs to be done here.

Thanks,
Qu
>
> I'll fix the last patch, meanwhile please remove it from misc-next.
>
> Thanks,
> Qu

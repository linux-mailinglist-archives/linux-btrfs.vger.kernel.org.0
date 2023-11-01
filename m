Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376107DD973
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 01:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjKAAES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 20:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjKAAEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 20:04:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2CED;
        Tue, 31 Oct 2023 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698797028; x=1699401828; i=quwenruo.btrfs@gmx.com;
        bh=gMOv1+3vWk4OkVxqo5WDf23IIgeLMSCbAOSTC/28Fxs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=thGbe+XhJ9IS2CpLPtfcN4Dr7SqBH5ol29Auug0EWa6ac1S8YKPkHmijeXrshfDj
         RhZAhEoCqLS5UQYv8HyntRHQ2TBewsjw2SBaNvCBC3aY2GVYO93VIfvrlDuXtN7oh
         G3SwF58kfn8gC2MZWVpnVvkOPuMEV0DbwNtuC3tIv8HXc+zJtl7VF8AsBjNJis956
         wLpfLbLfHIseHHAtkCtw+HaasmxKcPG4WQyiY2ZIjpFcbUQkNvqDyn+/bbDGv6CSx
         Bn3n+y6jqseKbOGRs4ZS0XmN4vOu+Q6Pgg5nnncyE3/OzHhSVbRQYLZBklZFNeHHW
         kNYrPrtGOqfWEXIRmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsZ3-1rEm5c3Fnz-00HO5g; Wed, 01
 Nov 2023 01:03:48 +0100
Message-ID: <413e2e17-868a-4ce7-bafd-6c0018486465@gmx.com>
Date:   Wed, 1 Nov 2023 10:33:41 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org> <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org> <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZUE0CWQWdpGHm81L@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4lbyL8tDGy2Her4bnAZRbOQfW9TN54Yyl6iaMssl5x7lq+dNDTc
 LctiC0LIkx3oRSU65OoyWazKG7NnL+lYNmveYH+vY8sd+284cq6Cwnh/BNevAkpdCAbpDd0
 uMIft+3gE4TOEAOiSHV66eyj7pgbDc0BZA7rm5yJF27avBXrb+rpxH1DNGcpRMOiOWhjcZG
 gmPK9nAkciE2QU5MFSk2Q==
UI-OutboundReport: notjunk:1;M01:P0:pFn+bQL7J+c=;PB+Hd4aJVTTReF/xYjhWpcY/9QI
 p17rK9z9bpRAeYMmjTfycalPIepvNPby+YcYXkgwNmLXRRBqmmHRkNQyv8HrbS3wZXlRcIwjs
 UtmXhk2o+LRm0DSeOY5qPSZ/cHmuyhcW1cm+Z7SAO7v0EM0HchBGSED4L+q6Nn4qT3xAxCCKL
 nInZpd7pq2BPa+UlRRzN0uxDeqGCyi2jr+84TGNmFySPnsVP+bvo98EjT0B+5fBZm67V2zehC
 qlrAk9IGKs1p0q5cCR/6cpKSa364oSBvD4hexQ3ivi7Y0H0WhppWH+/v7JMipVYKdiWwyPii4
 IlHAYSQVeM2m8YF7jpRziJL4mT9J6kfEW3IgHbkW4pWFsTK20JQAhyvFIdbfgDvFT86dPMBlS
 w/2De0s4E3ZEgIna5iZtr33WffTQ3nRkelFd6BEG6DVxmzIB3Nu4aKouZmInINWsv8tzP0sJQ
 2sWDe+7PF4s+uOLzV4HGaE3GWtov5NzuVTkPevQEFLihVIYpvSaPczAGnqRk/SH7XraBCwlTw
 TUjpWmg39oYplckFTlte/dW6pUZqe4c6kMezsicRPLjweGNlI3uNRMki7Ar5nC81560zmhcvs
 tqf5ab78fgnoRhfTwy+IvsVYqp+vbCMKKpRn43jLxkKzMuGg+NuRZuYq2gHVT7bcCdgMET9KT
 gcaEurLT/TO2OnfA5VbsDLBeC2GXqs7g/fMOn5yvSSZgA3spX9tUVVjBG2ygigjIncHdsTGPt
 BsQ7ggRx+xMt6RXLeuSInQcDC+7rh+dopunuWxOMcsSiAePULpD2VpZ1ycNiQp0e1IkdKJoQ4
 xxmRFtwlj82hLLw1qERloQCE6ql+9xRv3PDfb4MoSQar5BsuiCU6L6mJn1Mvx4ADF9K/BSrhr
 yHO1i4TCFHYdaT4J5DQQ1T0jaul+djweMECSP813YonLBdU7KbTwu95PlqOVV+uiQ3syoa41g
 EpfPKFoNq6VsCZwoFoipFBI8HGU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/1 03:36, Christoph Hellwig wrote:
> On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
>> So this is effectively a request for:
>>
>> btrfs subvolume create /mnt/subvol1
>>
>> to create vfsmounts? IOW,
>>
>> mkfs.btrfs /dev/sda
>> mount /dev/sda /mnt
>> btrfs subvolume create /mnt/subvol1
>> btrfs subvolume create /mnt/subvol2
>>
>> would create two new vfsmounts that are exposed in /proc/<pid>/mountinf=
o
>> afterwards?
>
> Yes.
>
>> That might be odd. Because these vfsmounts aren't really mounted, no?
>
> Why aren't they?

So did you mean that, if we have a btrfs with two subvolumes under the
fs tree:

  /subv1
  /subv2

Then we mount the fs root, we should have subv1 and subv2 all showing up
at mountinfo?

Can we make this more dynamic? Like only initializing the vfsmount if
the subvolume tree got its first read?

>
>> And so you'd be showing potentially hundreds of mounts in
>> /proc/<pid>/mountinfo that you can't unmount?
>
> Why would you not allow them to be unmounted?

This unmount may not make much sense, as:

- It break the assumption all subvolumes can be access from fs tree

- We may re-initialize the vfsmount every time we read that subvolume

But otherwise the vfsmount per-subvolume solution looks at least worthy
a try to me.

Thanks,
Qu
>
>> And even if you treat them as mounted what would unmounting mean?
>
> The code in btrfs_lookup_dentry that does a hand crafted version
> of the file system / subvolume crossing (the location.type !=3D
> BTRFS_INODE_ITEM_KEY one) would not be executed.
>

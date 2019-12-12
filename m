Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A511C5A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 06:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLLFzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 00:55:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:56077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfLLFzD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 00:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576130091;
        bh=SeToSMnW4anFz+3tE74nBphU3DwTY6g32YK9rMmxiUk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fs8vij8jZxAGr9urwzlFMf3XYF25p2tvyEJJTCYiCSf2mN6dqYpoAxH62uOkn/tlp
         4p/s1jDCZ9rdVbzb64WlMI5Hh/Df2omgxLAkZ6BsEzZOB/VWFLITurk0R2QEcfh9WC
         TzOxHB12vF6IB3TPcy9GOux3xh0RKbNrFJJSfDtE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHGCu-1iS69K3yoy-00DKBb; Thu, 12
 Dec 2019 06:54:51 +0100
Subject: Re: [PATCH] fstests: btrfs/09[58]: Use hash to replace unreliable od
 output
To:     Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20191212053034.21995-1-wqu@suse.com>
 <20191212053750.vxikimln5pjbaaot@naota.dhcp.fujisawa.hgst.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <8a96e22e-fe5e-6432-0b5c-cab4ecf915c8@gmx.com>
Date:   Thu, 12 Dec 2019 13:54:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212053750.vxikimln5pjbaaot@naota.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RBhjLxle11xHZZ3rds8k+ZqFwe1T0AkO6MuRtwhSqw400wAX1Z/
 tAvNy+VSGojRokJoLMl00eWT+y8TrPFKCbFpHK7ISgmSPGO/S3pUMj9tO/Y09uvDqAg130O
 KOPv7I6JBl6/jz5r2oBafJR3540hU4H0IBIVrGdnQJ0PTdBxafKqkTVPwa90i5HXeTNCgDs
 moK8afHyLQdU7H36J3miQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DyOFFb8Rr84=:zQhJ7JFLEQGSbh/pzNdKBs
 TDyKkS0Z6grQME0BLy7ti6yBoyPodtFxMkMdGXdW9QRiiVRED7ARKczEGonvr90YQ+v9T9JvQ
 /4KT+Sgr+Np8xw9inep+7b7wYHVCXTvlnVLsSD3K9RktgbKvHfaZ2lVCxUPQcTh6++3N1MLzE
 949531CsK6xuVGamf3xHIajpCWVnhPtO+WBtBDzg+zS9PxcPkAyqGzCleHKbKGAhT/daS+xb+
 7CJV6XjUuuAcIA/uIvu1FSWf0b1ddxHTEstcUpvv98HAhyVtr1knwaTSzC9cZLL+nRwWd1kNE
 L9kGAOraP1l2KBlioX3VmnRCNFoOCm8WcjnV7MZyH3XSZqPUF+z/lTPJH3A2YQM+WqroTF3UG
 0/gEJ65q4oFieSS5EZgR/H+uc3TL7vq7i472NUahkF7xYUdmyMm95LfRBL2vSqUpNhRL/d1s4
 g9/UhlyvOQ1lV0DOF8KddmRM0CPWZ8ROBQ0eiNrUJoi37grCTXpfN9gd+y4RrN19NoB6IQdrt
 cGNTKHdQxfwmxkzSrafnhfsAeVavlkarnBEAEJ5lRot95aKwGK+W0ZAxTvvhZweHcSQq6u+JJ
 nB1iwvURu1SevH2tHrz6OBCE92HTMyMPABXCrxaCVa5IKxfIdp18foWRMUFxLPAPkh5Kx20FH
 zlzzIeNrOsqUC0Gt5hyo/46rYrRUdX3QAV4nih2LoX05Ti/fOQyOchEcaBeRX1GGHSstTzmwG
 CdWhVe47wOFJT7M8ggPBCTGe6knkdPDOxJbVUqMVQGXaIqwujZL8/JVW8cHykPOotXj4pAifz
 wc5JeczHrPxgaMaD215qKxDgxwrHSe49qW3V+v7suW5Oiux6a4nHwDEkEHzAmx7y2ECdgi8K0
 9XySni7NTQWXRQAG3UU8ipBPLjiaKlCdwz7f1M/eeoucitG07r+Skw7xlmChxApBaJdmHhlP2
 zvjhsn8aRzApM3HTpc7s63W7fFaAzmZfVLxxJ6xs/VqE/lNBhi5XGV7m28x+M5oGb5rKoq4MQ
 6VR2W6js3MP/ZzFRjyNKNBAXxZsqBqNYsdSi8nfm26n0WdLBqDUSUrlPRrsQWk30kuz1mAMkj
 qAuggIkGV4T6x/qYYuteMUonkaE2+e07zVaNdMFJ3zeqiG7r2vYoM0Q5cRXuXRlhjnjS1EtWQ
 DXQKowYTcbfy2vnXsWnB3TmUV74rRnt0NyysiZRjCvrfTvw6/7Vw8HXJSNyW32XPm7T7OlpV1
 +l63yffHct6NKisJUQBNStO9wZcopr1ckS4E/XJrqjyPRi2iePp7JrlszfkUk/NwE3eX9MHJO
 qRP9hNdY/DE5+NNodFFbj+WMORYe4Z4U4VM6EIm09fC3OsyyVezoPiKOkqktAFQC2SS+Gui2s
 4TNBbclY6cJ4nQUmQBzFzExs5XzIB7gPzyNl5ig7jQTKrBz7C6Di3EX+xUmcDgfPmCRhDgNi5
 4ai/GkG8uBbVnIq+xveV0RfZZ+NZNvhBGVqtlc898jTtjJXOu3yHY+LoOTK2fdZJDmqsuMV/X
 e6XrdSHA9SM20QEuovRQaf8w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/12 =E4=B8=8B=E5=8D=881:37, Naohiro Aota wrote:
> On Thu, Dec 12, 2019 at 01:30:34PM +0800, Qu Wenruo wrote:
>> [BUG]
>> With latest master, btrfs/09[58] fails like:
>>
>> =C2=A0btrfs/095 2s ... - output mismatch (see
>> xfstests-dev/results//btrfs/095.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/095.out=C2=A0=C2=A0=C2=A0=C2=
=A0 2019-12-12 13:23:24.266697540 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results//btrfs/095.out.bad=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2019-12-12
>> 13:23:29.340030879 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -4,32 +4,32 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File contents before power failure:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0 -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa=
 aa aa
>> =C2=A0=C2=A0=C2=A0=C2=A0 +771 aa aa aa aa aa aa aa aa aa aa aa aa aa aa=
 aa aa
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0 -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb=
 bb bb
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-dev/tests/btrfs/095.out
>> xfstests-dev/results//btrfs/095.out.bad'=C2=A0 to see the entire diff)
>> =C2=A0btrfs/098 2s ... - output mismatch (see
>> xfstests-dev/results//btrfs/098.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/098.out=C2=A0=C2=A0=C2=A0=C2=
=A0 2019-12-12 13:23:24.266697540 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results//btrfs/098.out.bad=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2019-12-12
>> 13:23:31.306697545 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -3,20 +3,20 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File contents before power failure:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0 -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa=
 aa aa
>> =C2=A0=C2=A0=C2=A0=C2=A0 +537 aa aa aa aa aa aa aa aa aa aa aa aa aa aa=
 aa aa
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0 -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-dev/tests/btrfs/098.out
>> xfstests-dev/results//btrfs/098.out.bad'=C2=A0 to see the entire diff)
>> =C2=A0Ran: btrfs/095 btrfs/098
>> =C2=A0Failures: btrfs/095 btrfs/098
>> =C2=A0Failed 2 of 2 tests
>>
>> [CAUSE]
>> It looks like commit 37520a314bd4 ("fstests: Don't use gawk's strtonum"=
)
>> is making _filter_od doing stupid filtering.
>
> I sent a fix to the list. That commit is parsing od's offsets as decimal
> which actually is octal.
>
> https://lore.kernel.org/fstests/20191212031152.1906287-1-naohiro.aota@wd=
c.com/T/#u

Oh, that's much better.

Although that _filter_od still seems can't handle hex.

But anyway, that's a better root solution.
>
>
>> [FIX]
>> Personally speaking, I don't really care about whatever _filter_od is
>> doing at all.
>> And since these two test cases only care about the content, let's use
>> hash to replace unreliable _filter_od output.
>> While move the filtered (and meaningless) od output to $seqres.full.
>
> I think using hash break the tests on non-4k blocks.
>
> Actually, they both once used hash, but changed to use od with commit
> 55144172825f ("btrfs/095: work on non-4k block sized filesystems") and
> commit 2099e00681dd ("btrfs/098: work on non-4k block sized filesystems"=
).

Forgot that.

Thanks for the info,
Qu
>
>>
>> Reported-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> tests/btrfs/095=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++++----
>> tests/btrfs/095.out | 36 ++++--------------------------------
>> tests/btrfs/098=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++----
>> tests/btrfs/098.out | 24 ++++--------------------
>> 4 files changed, 27 insertions(+), 60 deletions(-)
>>
>> diff --git a/tests/btrfs/095 b/tests/btrfs/095
>> index 4c810a5d..4b381a9e 100755
>> --- a/tests/btrfs/095
>> +++ b/tests/btrfs/095
>> @@ -122,8 +122,10 @@ $CLONER_PROG -s $((768 * $BLOCK_SIZE)) -d $((150
>> * $BLOCK_SIZE)) -l $((25 * $BLO
>> # fsync and before the next transaction commit.
>> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>>
>> -echo "File contents before power failure:"
>> -od -t x1 $SCRATCH_MNT/foo | _filter_od
>> +echo "File hash before power failure:"
>> +_md5_checksum $SCRATCH_MNT/foo
>> +echo "File contens before power failure:" >> $seqres.full
>> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>>
>> # During log replay, the btrfs delayed references implementation used
>> to run the
>> # deletion of back references before the addition of new back
>> references, which
>> @@ -135,8 +137,11 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
>> # failure of the insertion that ended up turning the fs into read-only
>> mode.
>> _flakey_drop_and_remount
>>
>> -echo "File contents after log replay:"
>> -od -t x1 $SCRATCH_MNT/foo | _filter_od
>> +echo "File hash after log replay:"
>> +_md5_checksum $SCRATCH_MNT/foo
>> +
>> +echo "File contents after log replay:" >> $seqres.full
>> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>>
>> _unmount_flakey
>>
>> diff --git a/tests/btrfs/095.out b/tests/btrfs/095.out
>> index e73b24d5..5c3ec951 100644
>> --- a/tests/btrfs/095.out
>> +++ b/tests/btrfs/095.out
>> @@ -1,35 +1,7 @@
>> QA output created by 095
>> Blocks modified: [135 - 164]
>> Blocks modified: [768 - 792]
>> -File contents before power failure:
>> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>> -*
>> -257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>> -*
>> -1431
>> -File contents after log replay:
>> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>> -*
>> -257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>> -*
>> -1431
>> +File hash before power failure:
>> +beaf47c36659ac29bb9363fb8ffa10a1
>> +File hash after log replay:
>> +beaf47c36659ac29bb9363fb8ffa10a1
>> diff --git a/tests/btrfs/098 b/tests/btrfs/098
>> index 0e0b5123..e42e3146 100755
>> --- a/tests/btrfs/098
>> +++ b/tests/btrfs/098
>> @@ -69,8 +69,11 @@ $CLONER_PROG -s $(((200 * $BLOCK_SIZE) + (5 *
>> $BLOCK_SIZE))) \
>> # first fsync we did before.
>> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>>
>> -echo "File contents before power failure:"
>> -od -t x1 $SCRATCH_MNT/foo | _filter_od
>> +
>> +echo "File hash before power failure:"
>> +_md5_checksum $SCRATCH_MNT/foo
>> +echo "File contents before power failure:" >> $seqres.full
>> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>>
>> # The fsync log replay first processes the file extent item
>> corresponding to the
>> # file offset mapped by 100th block (the one which refers to the [5,
>> 10[ block
>> @@ -95,10 +98,13 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
>> #
>> _flakey_drop_and_remount
>>
>> -echo "File contents after log replay:"
>> # Must match the file contents we had after cloning the extent and befo=
re
>> # the power failure happened.
>> -od -t x1 $SCRATCH_MNT/foo | _filter_od
>> +echo "File hash after log replay:"
>> +_md5_checksum $SCRATCH_MNT/foo
>> +
>> +echo "File contents after log replay:" >> $seqres.full
>> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>>
>> _unmount_flakey
>>
>> diff --git a/tests/btrfs/098.out b/tests/btrfs/098.out
>> index 98a96dec..e3db64a0 100644
>> --- a/tests/btrfs/098.out
>> +++ b/tests/btrfs/098.out
>> @@ -1,22 +1,6 @@
>> QA output created by 098
>> Blocks modified: [200 - 224]
>> -File contents before power failure:
>> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -341
>> -File contents after log replay:
>> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> -*
>> -310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> -*
>> -341
>> +File hash before power failure:
>> +39b386375971248740ed8651d5a2ed9f
>> +File hash after log replay:
>> +39b386375971248740ed8651d5a2ed9f
>> --=C2=A0
>> 2.23.0
>>

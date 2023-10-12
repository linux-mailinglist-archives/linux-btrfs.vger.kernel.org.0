Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A87C6647
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 09:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbjJLHHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343567AbjJLHHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 03:07:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F93C90
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697094457; x=1697699257; i=quwenruo.btrfs@gmx.com;
 bh=chSIWfTaJ7lhTDXeDMAUriVmhSHVCiUeJOFBMhmjpEQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=m/udL3Yu5kNKqg6+0Cy18IhBxbMISpF/p0Vgh7mJiaHqn07PRzUjYxL7AhKgM2eAjoVVZnh6Ebu
 8CglENUf3jKRnqMO7LkFwTvdPRGvK0HJ73fqvaN16EZPNOWcfeO7WEThLBucxEPoUNCnDo34EiE9q
 9LO0wa66LDF+RFc7VmH6WCCy/h/LziE3zM/I9PwATwIm3/HWu57Z88hQItCepabjLFG0J1UVr3JLX
 IMlprmlViVxwUBKmsmEhAbj5Ix0ccD3DNu9745DlW/Qu3h6xizt1gT5IXDJd3Li6URhVQ6fhp9o/Y
 1pCV1HJBLkD3u386DcJwSAWg6KnlJodZLM8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1qwJQz03bQ-007mhd; Thu, 12
 Oct 2023 09:07:37 +0200
Message-ID: <f72ce467-b8c8-4373-a0ab-23e0631a5b27@gmx.com>
Date:   Thu, 12 Oct 2023 17:37:32 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject unknown mount options correctly
To:     Su Yue <l@damenly.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <a6a954a1f1c7d612104279c62916f49e47ba5811.1697085884.git.wqu@suse.com>
 <cyxk1i2x.fsf@damenly.org>
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
In-Reply-To: <cyxk1i2x.fsf@damenly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHksbIfx+LfQkbnb7domkSx1dAwdFWKLkO+/r+r7fB6aCC4IBQZ
 wRnmjIOj+YYsaupxK10p2VknKU2YCCWpziUfNjySw2x+2CnRq6/3VM27orroUUJA79iCQ5J
 MQpVoZ3KQ3LKkS8WO232e38BWPHoa+yk88tK/eC6Zx2N6wZQHazGeJxUJ+7jk0kRNtBg2gz
 BZkOh6YrGIbXSQvP3hN8Q==
UI-OutboundReport: notjunk:1;M01:P0:o89fWVFTVoY=;awyu34HZQE0Pz1f8XFNxiogw+1N
 PHjqHmAtce6+fL1tJhVkfavjNRVMBfRZd01Ji6SZXskSQz9ED59ciKruwHQ+BMGiR0ul1VP18
 jXMOOYvZ0dB/59b73rqVEfkoxUdI+RG/QiiGf55MtpKccEdb8lRgl1/VKVFIATnzs2bdAnGyX
 cwqfx2kcvqMN5J5tihBc05ZEr/V7gm21QrbduHKa0G4lwy7VoIvz336kYZHuNA+GvvPfHk7+Q
 G7S4jAnHeXG29DMOJhScbzN/0ltCEPNNrd8hHPXoo0x9aTx5fjKP4tTMjd6k9bk+iZToHY8MA
 NC7VmE1THo1iglm/erZ4IHGnF28kIzFiNu5n3Nlx1y5QKmJhBt6+kzbFivPtAfaV1tEekOt2W
 iNeoZmiZ6UbKkr5ikpCUvPsNnDyxoMtv9d3oE7W+CI6JithP6GWghLZcjRgPKk8baR9EyJ1F1
 rGgmt1S6ouGh2oXAjDCU5nAPj46wHy17zVpAfKkeExeyV14b8beA1U+8jH2xCInsBKxaJryR2
 Tv+zvHxfXpKDf9o1nhPpIdk/xx3wemCF8RQwvhXjvQq2yCx54TZizh4j+0aw7KmLt7YiV5gX5
 NTRJW1sHz4Vf2nuecDj+X0G2sqXn6KzmuTefyYlTSCiBPOk8uLowlWGHkOf0jey/ztCz4PkWv
 a9sqxCKZvzJ6gYRYD5FZDg9oGa1LyY2vVug3zaG/eGu0F/tRs0DGYKrQ1KVU5rSW9ylZKf0TC
 s+Fut/KYb4b9qqJv8R0XxOaMgklnQ///xeP8A+IiGDwX3rECJce3Jtddj/ogIW2m7OfbxmBil
 fxKUdlWKsI94/XHv2k7W7TAgTXgoGDj7MCpq9EqokBvOJi0of8SR2D/r0nBefy/lsGNKCsMkE
 Vh+/RqZYZYfEP05bOKZLxSPTKKyFS5qReAI8/IFe7vGzM8JQwCrmg68c6K1wD97WjtS1Q9373
 JS8oQ9hnW6MtvFkWy3pU1i+UDUs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/12 16:31, Su Yue wrote:
>
> On Thu 12 Oct 2023 at 15:14, Qu Wenruo <wqu@suse.com> wrote:
>
>> [BUG]
>> The following script would allow invalid mount options to be specified
>> (although such invalid options would just be ignored):
>>
>> =C2=A0# mkfs.btrfs -f $dev
>> =C2=A0# mount $dev $mnt1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <<< =
Successful mount expected
>> =C2=A0# mount $dev $mnt2 -o junk=C2=A0=C2=A0=C2=A0 <<< Failed mount exp=
ected
>> =C2=A0# echo $?
>> =C2=A00
>>
>> [CAUSE]
>> During the mount progress, btrfs_mount_root() would go different paths
>> depending on if there is already a mounted btrfs for it:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0s =3D sget();
>> =C2=A0=C2=A0=C2=A0=C2=A0if (s->s_root) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do the cleanups and reuse=
 the existing super */
>> =C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do the real mount */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D btrfs_fill_super()=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> Inside btrfs_fill_super() we call open_ctree() and then
>> btrfs_parse_options(), which would reject all the invalid options.
>>
>> But if we got the other path, we won't really call
>> btrfs_parse_options(), thus we just ignore the mount options completely=
.
>>
>> [FIX]
>> Instead of pure cleanups, if we found an existing mounted btrfs, we
>> still do a very basic mount options check, to reject unknown mount
>> options.
>>
>> Inside btrfs_mount_root(), we have already called
>> security_sb_eat_lsm_opts(), which would have already stripe the securit=
y
>> mount options, thus if we hit an error, it must be an invalid one.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This would be the proper fix for the recently reverted commit
>> 5f521494cc73 ("btrfs: reject unknown mount options early").
>>
> I'm a noob about selinux though. Better to draft a new fstest case to
> avoid further regression?

For SELinux enabled environment, any test would fail, thus I wonder if
we really need a dedicated one.

But as an Arch fanboy, my VM completely failed to catch it, nor even has
the needed user space tools by default...

For the invalid options rejection, we could definitely have one test
case for it.

Thanks,
Qu
>
> --
> Su
>
>> With updated timing where the new check is after
>> security_sb_eat_lsm_opts().
>> ---
>> =C2=A0fs/btrfs/super.c | 46 =C2=A0+++++++++++++++++++++++++++++++++++++=
+++++++++
>> =C2=A01 file changed, 46 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index cc326969751f..4e4a2e4ba315 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -860,6 +860,50 @@ static int btrfs_parse_device_options(const char
>> *options, blk_mode_t flags)
>> =C2=A0=C2=A0=C2=A0=C2=A0 return error;
>> =C2=A0}
>>
>> +/*
>> + * Check if the @options has any invalid ones.
>> + *
>> + * NOTE: this can only be called after security_sb_eat_lsm_opts().
>> + *
>> + * Return -ENOMEM if we failed to allocate the memory for the string
>> + * Return -EINVAL if we found invalid mount options
>> + * Return 0 otherwise.
>> + */
>> +static int btrfs_check_invalid_options(const char *options)
>> +{
>> +=C2=A0=C2=A0=C2=A0 substring_t args[MAX_OPT_ARGS];
>> +=C2=A0=C2=A0=C2=A0 char *opts, *orig, *p;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!options)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 opts =3D kstrdup(options, GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!opts)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 orig =3D opts;
>> +
>> +=C2=A0=C2=A0=C2=A0 while ((p =3D strsep(&opts, ",")) !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int token;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!*p)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
tinue;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 token =3D match_token(p, to=
kens, args);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (token) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case Opt_err:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btr=
fs_err(NULL, "unrecognized mount option '%s'", p);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +out:
>> +=C2=A0=C2=A0=C2=A0 kfree(orig);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0/*
>> =C2=A0 * Parse mount options that are related to subvolume id
>> =C2=A0 *
>> @@ -1474,6 +1518,8 @@ static struct dentry *btrfs_mount_root(struct
>> file_system_type *fs_type,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_fs_info(fs_=
info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((flags ^ s->s_flag=
s) & SB_RDONLY)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error =3D -EBUSY;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!error)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or =3D btrfs_check_invalid_options(data);
>> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(s->s_id, size=
of(s->s_id), "%pg", bdev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shrinker_debugfs_renam=
e(&s->s_shrink, "sb-%s:%s",
>> =C2=A0fs_type->name,

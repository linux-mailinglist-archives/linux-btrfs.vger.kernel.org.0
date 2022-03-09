Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79C4D2FE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiCIN0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiCIN0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:26:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42AE1795F2
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646832349;
        bh=JHrWqE3jAhom9zeBESOnnUt4/VuoI8sGHkaJyrpO1ZA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ene8TW6a7oNDAxP9QtP600AQqDAqMWRgTU8VFA7DMtD4U42cdpeFyRSQIwtd+O8MS
         KqZztuEbPP6ji23Jo1Bh3l9yC6f24W5+p8ac7SnFws9ETbee1H+H+FlrWpC9w+F3o+
         XtT+TdODpu1ZsGRvi7UrmndoYAIxRQsIuDVX/t9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M72sP-1nW4mZ3aJD-008dJt; Wed, 09
 Mar 2022 14:25:49 +0100
Message-ID: <41958102-fdb4-7558-b7a4-c38560679809@gmx.com>
Date:   Wed, 9 Mar 2022 21:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] btrfs-progs: subvolme: remove unused options for
 create and snapshot
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220309081418.46215-1-realwakka@gmail.com>
 <4a594830-8a8c-dbe3-15d0-1a62a1adfaa2@gmx.com>
 <20220309131745.GA46482@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220309131745.GA46482@realwakka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eotGn0Y11JMNOcucHZhQiDKFfvCwmgVMmLciX1xtiiYaJUORF7G
 0pOGv0z23wTbi4XD0MSG6WceszIstC2c01yrAtOeLeqj5RcrhFXhNE9uZNBu01kFwfSYqEt
 PReNI2vkF84KOWk0yptW6e5615fXuT3vhPAJ/EZeyCu+ck2MJbq2kMjexkO9qJifDM8iiX5
 OA2CkDTDYPY9hDR2Clz7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l0PYKJJLItU=:IGtAEiT57NO75WbMIHyg+o
 NS5giwpZMjXUzDxFj13twGHD4Z/9u0Cm9lwjO2LHFNiTdDWBzydrDCnh5wdqL2O9g1vBtVVzt
 zQnZ+mNS22m28/2fzEdKWy/rlV4NXeYiNNNx5Y/GxoxkI8y0wevr6pNM8+BbxsS8aasPh+pw6
 sedqMgzXj+bSDEZ211fOKff46z+1Rhg8Gf+1pmJpjzQ5vfQjUK1G4QiR98TrTnbKfWYaTeJSs
 1HZXZcF+Jagdlt4HU8/46ZyueMKc/ZB8jP19fPT8CuASdQVH/xOg6XA/VNxAeRlo7Papm9kCy
 rDtO6vKxzeHuCsbeDCoW8K5H12iAre1YEBqMCOw7WHjC9nUG0mQJlvQ0J5Eb9w5+17953jctj
 Af4F0o2k04Y1J/nK16dCtQZjUeRUwsses5pHXrlvNB7Kzz0oZe1D+Ty2ki5WkV7YBg0YywlFD
 LhkZuKAmmRePaO5AEGbCEBNGA9OutpZdZTfE/Z1HbrrIg7GBVd0GAAKnIAktZ2PZUFQiQpKc/
 VgcN/AMGNgySzqGaAoiMkS2Dh7OSAi42uaZvRc6wz91XjanQG2EflmiQxNKiY24C5/wqdaugA
 JkhyNfbkqtmO6r40vDcqIqEfgmm7Gfkyh8eyp7Hyd2M6Bi0QfmSc/CsW9YeMYJbpNck9kWgRv
 C5vUng/ECxi9eemnhBjm7dhiiaS0QZi5/HImlp8drW0M5boXS6Cq5depqniydZsIdlSTSxWJ/
 4Xz+bWcJ1vnzPvFp57elZOdRNBgQxD629hwFtJRA+CRBs8BnCP/mc8Wn7tTclFl3++6sDecy1
 Vnr6POI21/rzoo3e4Sth92RnPHDfHC4kR2AAc7gBKLOYBwQbgTfv3E31UmNG+TLnbtoPujPqO
 Ytsuof1sNZjGsBH8Kd6Qcoon/rBrkoX8iOjlQA3LUSNS3kxCOg5ILdOdBgftYeniQIDPpmC/U
 m4FFfJfdY13zJbGhs85JpfchxPnbeu3g0FBH5Q++Y/XuaN7Du/9rny1xtD12iaHye7DC5MgB7
 dC1L1xD7grtiwiN83ZQFgazU3ivJ9+YV/VfHmPAE8Us/ubtubTRsEYFVxbueQnHR2x8aQmFDn
 /bRMfeuCjQ3vhc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/9 21:17, Sidong Yang wrote:
> On Wed, Mar 09, 2022 at 04:52:15PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/3/9 16:14, Sidong Yang wrote:
>>> There are options '-c' in create subvolume and '-c' and '-x' in
>>> snapshot. And the codes about them is there, but not in the manual or
>>> help. This codes should be removed to avoid confusion.
>>
>> I'd like more explanation on why we don't use it.
>>
>> In fact the truth is, those -c/-x allows us to directly copy qgroup
>> numbers from other subvolumes when creating subvolume.
>>
>> This is definitely going to screw up qgroup numbers.
>
> Actually, I don't understand that you said this option screw up qgroup
> numbers. Could you explain more?
> I checked that -c/-x options are not working. The commands are like
> below.
>
> # btrfs qgroup create 1/0 /mnt
> # btrfs qgroup create 1/1 /mnt
> # btrfs subvol create -c 1/0:1/1 /mnt/a
>
> But it's not working. It seems that it ignores btrfs_qgroup_inherit
> argument. New subvolume doesn't inherit anything.

Those -c/-x is for qgroup refer/exclusive copy.

Check btrfs_qgroup_inherit(), there are two for loops, one for
num_ref_copies, the other for num_excl_copies.

In those loops, we just copy the number directly.
(And of course, mark qgroup inconsistent).

Thanks,
Qu

>
>>
>> Nowadays btrfs qgroup will automatically inherit the qgroup numbers whe=
n
>> -i option is used.
>
> Totally agree. -i option is enough to use.
>
> Thanks,
> Sidong
>>
>> So the old -c/-x is no longer needed, and any inexperienced usage of
>> them will lead to inconsistent qgroup numbers anyway.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>>    cmds/subvolume.c | 25 ++-----------------------
>>>    1 file changed, 2 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
>>> index fbf56566..408aebee 100644
>>> --- a/cmds/subvolume.c
>>> +++ b/cmds/subvolume.c
>>> @@ -108,18 +108,11 @@ static int cmd_subvol_create(const struct cmd_st=
ruct *cmd,
>>>
>>>    	optind =3D 0;
>>>    	while (1) {
>>> -		int c =3D getopt(argc, argv, "c:i:");
>>> +		int c =3D getopt(argc, argv, "i:");
>>>    		if (c < 0)
>>>    			break;
>>>
>>>    		switch (c) {
>>> -		case 'c':
>>> -			res =3D btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
>>> -			if (res) {
>>> -				retval =3D res;
>>> -				goto out;
>>> -			}
>>> -			break;
>>>    		case 'i':
>>>    			res =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
>>>    			if (res) {
>>> @@ -541,18 +534,11 @@ static int cmd_subvol_snapshot(const struct cmd_=
struct *cmd,
>>>    	memset(&args, 0, sizeof(args));
>>>    	optind =3D 0;
>>>    	while (1) {
>>> -		int c =3D getopt(argc, argv, "c:i:r");
>>> +		int c =3D getopt(argc, argv, "i:r");
>>>    		if (c < 0)
>>>    			break;
>>>
>>>    		switch (c) {
>>> -		case 'c':
>>> -			res =3D btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
>>> -			if (res) {
>>> -				retval =3D res;
>>> -				goto out;
>>> -			}
>>> -			break;
>>>    		case 'i':
>>>    			res =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
>>>    			if (res) {
>>> @@ -563,13 +549,6 @@ static int cmd_subvol_snapshot(const struct cmd_s=
truct *cmd,
>>>    		case 'r':
>>>    			readonly =3D 1;
>>>    			break;
>>> -		case 'x':
>>> -			res =3D btrfs_qgroup_inherit_add_copy(&inherit, optarg, 1);
>>> -			if (res) {
>>> -				retval =3D res;
>>> -				goto out;
>>> -			}
>>> -			break;
>>>    		default:
>>>    			usage_unknown_option(cmd, argv);
>>>    		}

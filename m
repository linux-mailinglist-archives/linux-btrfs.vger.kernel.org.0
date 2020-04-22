Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6021B4700
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgDVOSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 10:18:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:47725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVOSN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 10:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587565082;
        bh=Hg/HQqlDxBFdehgeQupDAUc+Q+5qlvDzjlMIIhgLMO8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:In-reply-to:Date;
        b=FUzZPmk+QXmVNxRhVVuK5hrjsHvmG+prAnXSpw7jxcbaHYXoVZpi/ppdo9tHsRQc2
         PA4cTbvvtxxWH8Ux8vyNeEpttoYowNkb811Jg42xPjw6zmWX+PaiCrVMMl+jZtFKTT
         Ap0XlvRitMQaE/xyQ8XHOzTcDQx0bHLuGwQRHABw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from nas ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1jJsLt4C4T-00AFy5; Wed, 22
 Apr 2020 16:18:01 +0200
From:   Su Yue <Damenly_Su@gmx.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 18/26] fs: btrfs: Implement btrfs_lookup_path()
References: <20200422065009.69392-1-wqu@suse.com> <20200422065009.69392-19-wqu@suse.com> <368vvoni.fsf@gmx.com> <20200422120451.5864d812@nic.cz>
User-agent: mu4e 1.2.0; emacs 26.3
In-reply-to: <20200422120451.5864d812@nic.cz>
Date:   Wed, 22 Apr 2020 22:17:53 +0800
Message-ID: <h7xbob8u.fsf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Provags-ID: V03:K1:MWOOJ/nAh1E907d+q0y+J+akvYgFZjrtfA5DebJWyILLR49MeDf
 qCk6rHsJOhhEvfGUM0N9nov8Q5mSBa8nzAv9NRxEfZCZxbII80Ay8gchUyWd0RWhvS2uffC
 apDs1k4uREmH35XAGvLuW3pTeEZkT1iJHFJ6JbZi6MtVOVXXly06vUhGLsI4PkGfGmV8ctd
 BM/SKovW4b/n6SlD6J3vg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q71B+uHMjyw=:V1uklrH/I/262yZEGQXtcR
 4NIsnDYNMzpYMeSszZB2mLQuloLbK1/+1Bb3yx5Sn6hUWaKdL32+iymcn6SzcsvJLRvvnSkAI
 42ldZ5XKPOKOvspkwKx7i/fISt1prufXRAdjhqhWb/sfBCkG6pMohmR+VLCuOI8ShEz3BWCCS
 YbBguhSkQv9i4x6yopIxl7GJhZtgXtAigeS9Y378xdmAz7cVcKmWGqpMKojyaCnBpcIXG0Zqj
 iSZyrtJNlwFMtDTz7SOuBoxpvG8wa8Hmi3+l1vR57Pq6Sy+lRfz5zR71elL1SnNK8QsdjzXZ4
 9/CwNWF7zVZ80EwN+g7i5IXimp89NJ6efPz4epXolk716b3WEnPDhB56+5CPt0GbmpaYaEseL
 Nlj2q5gnJptrwQptBjHD9h5niZ8hXfF1gCBwU+2YxsYy0M3MrAH/y8vl8/HOJBIWYA6ChlUax
 Yu5eE83ffBjlOWR9/N0/bAWXRyEyOw8xMjIAlhoovPmUW0xNtBwL73Dxtmho8pgg7syzDTEH5
 UM45w6x7hvOKNzIeQ+fV1h8a+A9oEVaIZDTehPMjmRZo3vYmlsK9Xr03iD0/90e64Hq+rRjtX
 mMi5SmjoWwlrl3ZN2rxSQpBPpWxBS9mg5FJ9Y22fXMlLSeksQTu5xsSphXFkVTJO7gInKOBCa
 ZpQA3bTZZgRuxzrDEmpCJJQ39a3evI0dk0y4dw3CJmLpsTFj26hRUJdJEDLa1EHaAeplRQlzX
 S5yX5NgCD6O5oaQiJAnMLHjagbdZdGLi7T0DgM3vZiHV+sGxEipBv9c39BrjE59QnnR0LgZ5J
 Gx1EHxaU8ZUMXFRfx+QKt7X5FIHljIzl3S31V0w6D9uZ+Q4AJSklzbvAjdWUpEDC2/nY1bgws
 /Skv4D49VHdE2o8DgIXG2XmTnM7ZRX59DR2RMVKACDOTbWWe25tk/GlpXh5K/yFVfDBrVxCpa
 NnWPqTFTUoFH/1jA4IwP72J2pp7RLwBavnMt1Idsfzi2Qy2lkq+rr2hY9VneisSi+17cYF+28
 YkzPT6TAQ0mRCHkhRhfCQeaj6jHDMocPbdpxh9u/WPeJtsIKle1yHYG2DOcWrn3qENY4yaYRd
 I+mQRskLaM8Aysc2ePPjMTyAIl+nselxcZcWC4AfXEnxkYPgHOxHfpZE1NhjgYerzcGn70GVy
 firuA3DfA6Ih0gv+BcAaG5RWnkcUnWJ7rgNfm2M2k5agiPGQ71zWhsLJndJgf5NmDstxa5+aL
 mzZF4xjcHusRe4ObU
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 22 Apr 2020 at 18:04, Marek Behun <marek.behun@nic.cz>
wrote:

> On Wed, 22 Apr 2020 17:46:25 +0800 Su Yue <Damenly_Su@gmx.com>
> wrote:
>
>> > +	while (*cur !=3D '\0') { + +		cur =3D
>> > skip_current_directories(cur); +		len =3D
>> > next_length(cur); +		if (len > BTRFS_NAME_LEN) {
>>  next_length() promises @len <=3D BTRFS_NAME_LEN, so the check is
>> trivial.
>

Okay.
> Hmm. This is a bug in next_length. I meant for next_length to
> return len > BTRFS_NAME_LEN in case of too long name. Thanks for
> noticing.
>
>> > +			ret =3D btrfs_readlink(root, ino, target); +
>> > if (ret < 0) { +				free(target); +
>> > return ret; +			} +			target[ret] =3D '\0';
>>  It was done in btrfs_readlink() already.
>
> It is in old btrfs_readlink, but is it even after this patches?
> I don't see it in the new implementation.
>

You are right. The thing changed in the 17th patch.
btrfs_readlink()
doesn't set the null byte now.

=2D-
Su
>> > +
>> > +			ret =3D btrfs_lookup_path(root, ino, target, &next_root,
>> > +						&next_ino, &next_type,
>> > +						symlink_limit);
>>
>> Just notify gentlely this is a recursive call here. I don't know
>> whether uboot cares about stack things. But, recursion makes coding sim=
pler :).
>
> It is limited by symlink_limit. Until somebody complains about stack
> issues I would like to keep it simple.


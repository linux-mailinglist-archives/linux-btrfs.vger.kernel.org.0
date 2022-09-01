Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7A5A92CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiIAJNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiIAJNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 05:13:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A781114D0
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662023626;
        bh=MlWADbGeiDxaA32683Uh0fQTfhXZ0itCuteszjD+yHE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Uc9nsgV4uuOcSmavwLl/P86UjV9NLZVe1mB6cABjxEA/v43x9usUUAsKiVEEU/y9J
         4eghEQZtDfBWrrIARKJ9/lZtvj685y9jmDgtaS+sE5+yeWvdWfLZGxPdmap/EP+EG2
         +ECMeZ6YMDBus/DmBntxA1C4l7zl6WzbDURx9zmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1obsgR24Y2-00H9PI; Thu, 01
 Sep 2022 11:13:46 +0200
Message-ID: <4b534cc7-2a28-54d7-64a0-844b293eb4d8@gmx.com>
Date:   Thu, 1 Sep 2022 17:13:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: receive: fix a segfault that free() an err
 value
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220901083554.40166-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220901083554.40166-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wlgtQLgiXEm1bulR7ELsEAdSNsMCL6xThGMsrv+mvz+yPgARXuJ
 lUnHVrELnGE8Q21JN/ZEuo18hwTaaRmFsjV59idDuiaYyfWmIe7AOOs3285wx1vq+s2Bw7h
 wlz9AXSxNreMUfAzWySJOSTyOVm4ehiz+l+mPAngR6+qB1++tRnCs5z8U+yV+8pVJ9EOMyv
 xfhQ+HCMZABhD48GH/wFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:liVDJahwCzk=:eu49L36/EEEI4rdtIWTFjH
 0wqaeR9pDLyWBE0UP9gMQ3VATntIW9HTLQZp74bFs4tQSYYkK30GwUoxjWG2MxM+PtV3j+NNJ
 XbeB0H5eweyl25UuvvVQGQNeq9V+ObJ2bvhD3qFm1FoCQZvzf5ahmrsj83T+d5olp6tWK+/jj
 tukX4HwKJU8QNTXhwTlGdFNtMAw/p0AsjDrEIvCK6h+QgIoeZyXMGEv7hL2gYOsleJky3hgDD
 3IoG9kPKgaCjwFbUO7O4P9hPommwywRFeQZijjdZlWhsygViU4E55u/aVV67KXduqfdGQWndE
 x+Vs7fKcmSs5UufQ5b6wHgefdwo3RhxMIQK64wKvy71CcqPcNUBgt871ISAIBt+g4iLXiIOfd
 jZpLKg4OSjPBV5KdQSsLJl6Cn4MoMyx5ZrGRWkkISKz12TLlFcMyLZhZWzVGXMY506sw0JKLw
 gtYBGv/IkwQC1E/6HvUFwgvefO9vVmBcYPzK2RqzvTvaxFDHw97tx+de7e1vEQLiHN8mvZchV
 9i4lx0bk0Rga9994YmdPvDsp7bk8Cyv1YjhKcOQUy1BpZ2N35SU2vO7+vht/B1GjXT716G3mc
 nZdDZFjCrA0jpQJtH7eGkmOI/WhI+c+sODJWSjOXl9Ocuh1YwxSR7iEOniuy24TaDyX3pSiUv
 X4IpCGoHKBmE2aVt8+WCvS8zzpQsX0fMwu5/uiZo5Dqap8FeOkSYP8Fv6Q/Oz3LV3WoGXAKL6
 Dq1q7hcXne8Yy4SW7ZJmKKmnEn9UkUhEWyHAAKuqcoDC6ql5DglJC8Lp0gvZiddN0VC+hIEd0
 KEvqHWaEXtnJzgaV9SgFq3dkZnRpqaoMc/HRasf2hY9ibbDc09RJiDgSViww9KButYyMIiTZN
 CPjUdHdO0iuCvwu0a5ulOhdz1A13BD91VYbIx4reRC5nxw+7OZ50nO+ccFIxGATx9gViMxTO6
 B3iSpTt/BtN8wAcZMdZ6FT5UlsFdGMgHTQhtWjQr5pw7uFTGJGgqA+zZkz43Ua8U4pKZtIfzR
 zmdm8BnNAXdzAHQwrDDFqpHbNa2RBtb8W0m3+SmiqqWKLoFNlzNOJ0WixCuJj3oRBiQemUE+k
 SnvMouFzIBEssOJiRzjlH1BkSUBAZ1qc4om/0V8neHve3lov6hjk2EJ1Bq3XgORoV/Ab+bN3P
 FSiwwuk36KDy6XWFvBhta27VAv
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 16:35, Wang Yugui wrote:
> I noticed a segfault of 'btrfs receive'.
> $ gdb
>   #0  process_clone (path=3D0x23829d0 "after.s1.txt", offset=3D0, len=3D=
2097152, clone_uuid=3D<optimized out>,
>      clone_ctransid=3D<optimized out>, clone_path=3D0x2382920 "after.s1.=
txt", clone_offset=3D0, user=3D0x7ffe21985ba0)
>      at cmds/receive.c:793
> 793                     free(si->path);
> (gdb) p si
> $1 =3D (struct subvol_info *) 0xfffffffffffffffe
>
> 'si' was a ERR value here. so add the check of 'IS_ERR()' before 'free()=
'.

The reason looks good to me, but the code doesn't follow our standard.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>   cmds/receive.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index d106e554..cada6343 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -789,8 +789,8 @@ static int process_clone(const char *path, u64 offse=
t, u64 len,
>   	}
>
>   out:
> -	if (si) {
> -		free(si->path);
> +	if (si && !IS_ERR(si)) {
> +		if(si->path) free(si->path);

Such "if (condition) do_something();" is definitely against the common
practice.

Another thing is, that happens for the search failure for "si =3D
subvol_uuid_search();" line.

That's the only way @si can be a error pointer.

What about resetting @si to NULL in the else branch?

Some like this:

si =3D subvol_uuid_search();
if (IS_ERROR_OR_NULL(si)) {
	if (!si) {
		ret =3D -ENOENT;
	} else {
		ret =3D PTR_ERR(si);
		si =3D NULL;
	}
}

This removes the need to bother if @si is an error pointer or NULL at
out tag.

Thanks,
Qu
>   		free(si);
>   	}
>   	if (clone_fd !=3D -1)

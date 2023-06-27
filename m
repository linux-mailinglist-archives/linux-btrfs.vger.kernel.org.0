Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903EB73F88A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjF0JRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjF0JQz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 05:16:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D3726A4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687857405; x=1688462205; i=quwenruo.btrfs@gmx.com;
 bh=UcHZWs36E1kbyRNwNZApTR0iX0xsm8ILJRLN5k0w2X8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=MUGGAVMfvcE9EUlPl61fi+ZCd99wAJykH70YDN9kkGlXhq1W0agh635OuIER6F6buy9GFQ4
 KYFzybbkWICXLaCal1kg0jP7ZFrvUNznV++4I2YFYFSLqVXGwIBr9J/qu5G8kpkcpTVHxbA49
 WHvas7UX48O7tbT7IYfRs2QsSD6EIHtGCEsKgXaLLRxHaxllddqj0pigh6redRU53w0rvHiwH
 tHF5bfilwaFVWhiyAunDcWfCl/5bNy0MYu8P6BYTz9PeGeMCe1sTkbVktODPjJLy9dmdxyCNt
 1Z85jPiX7/iX/T6ee3E7plPLn+Rcx9Pzxm1vZ5BrhYZ3SESYp0tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1qemjN2fS5-00Qi3J; Tue, 27
 Jun 2023 11:16:45 +0200
Message-ID: <f6e5e3fc-9c59-bdbe-e88a-0e3340a10ae6@gmx.com>
Date:   Tue, 27 Jun 2023 17:16:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] btrfs-progs: dump_super: drop the label out and
 variable ret
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1687854248.git.anand.jain@oracle.com>
 <d59136fcbb28ead308886d5219ccb630530c4b37.1687854248.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d59136fcbb28ead308886d5219ccb630530c4b37.1687854248.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AkOLZIPADprW15/2/9R4n+x5ialcF11Qces4rRrzd0lWCtxxt1S
 tmS0F4dlIWXdHJIz5Mu7JIpete9b8qffhenu495dgw7UOi5Ua+r39XNaEsN+MxW8CsJ1fNB
 2dy+/T50l085uXtB1bPlg+dW+uBEah/ZwYqGOnUPVJ1E4GfrPj+UmiDvbMrRKDeSnZ+4rlZ
 vCj4hfhRbBI1H/cndFaaQ==
UI-OutboundReport: notjunk:1;M01:P0:cnP/EMXi+FI=;fagtwVkMgqT/RwjJfhEB0tV7JaY
 ZFsGuyb1io6WHCF2YcFX1MBm0yD8jIStU2uGwiNMn60a8wNqy3T/jzkHkz+CE/Mp+36BDyIn2
 g4ZnFiP35B8LAiYYY0cKPRpKk7Ah8BkcSL9LDBy5sxyr89CaWC3BPKW3W569jNF+/rztz4mVR
 GWFXB5j+KYK77J4m14JtvZaMoeheUeMJMLIiQ+CnH3kGpcJ1p/joCKQCAWhPkQ+p6XCCI1nRi
 Kwwgj1rd1byMJA8FJQeS4PVQFjROpqNJD9bbGsLrBpRaOa82fefL+tXJZORW0Kv7itBrxam4k
 iuM2wEyeCQQFXUi8W1OKwy6jE6cLC2xQtSqSv+uqEMm9a8INcNI2We8R6W6MRU3Aidxn2YRHC
 eHZBXoqeJpO1KnXdfaB/nXZ64+v7m5LhCCQvg9KJSQRuSqvxJTQ1bHVl74+U3uspXy67pDpEL
 iU8rIrnl+mlIJAcAih9o4nONSJzx9IqhLeuqSVXrLTrR0A0tXGNwVIOWqMKq0aqz8Z1NnuA1M
 8YycYrqpRlQu0PRr29fDzGbBIauVEqv6+e0dEF3QUKxLsuJjWVj3zY2hUhJymKCrJwb3h6HcN
 U2kj5N23M380Zj0tc2gU55rx/dh98Jv67K+icC1Ch6SU0H0L62IxX1mPo1wpCVkK6Pn8fOBVD
 HsUKt/PVUNFm5prN7nxUtZ+//ZaUBLYbagH3rwcVOfouww8D+m8UW9jjLhAVwSt4QtibKaJKK
 v8ZD22IbGFofTMA1+f4F1kDcN670UKppe6zDsznC8+ua/i4p25BwghpiG5fIa4wETmLePvu3W
 he6C6svryEgoL/mJlusHTNJo/S/wjmGqwQByGsVKphEQwiU6uxgn9o5V3ly5u1usZ6i5HXfEo
 bRj2wuO323qHWPvvsw0sfjaTSja5zLVYos7h3pdTcqdq7usZpjZ/y8qYA6iuKyyh0PyLxzAcZ
 Vu3/D5FKEupmkSV3L/I695i+rpY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 16:53, Anand Jain wrote:
> In cmd_inspect_dump_super(), at the label 'out', nothing much happens
> other than returning ret.
>
> At the goto statement to the label, in the for loop, we perform close(fd=
).
> However, moving the close(fd) to 'out' as well is not a good idea becaus=
e
> close(fd) doesn't make sense outside the for loop.
>
> Instead, simply return 1 instead of ret=3D1 and then returning it. Drop =
both
> the 'out' label and ret.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/inspect-dump-super.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index 4529b2308d7e..f32c67fd5c4d 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -84,7 +84,6 @@ static int cmd_inspect_dump_super(const struct cmd_str=
uct *cmd,
>   	char *filename;
>   	int fd =3D -1;
>   	int i;
> -	int ret =3D 0;
>   	u64 arg;
>   	u64 sb_bytenr =3D btrfs_sb_offset(0);
>
> @@ -156,8 +155,7 @@ static int cmd_inspect_dump_super(const struct cmd_s=
truct *cmd,
>   		fd =3D open(filename, O_RDONLY);
>   		if (fd < 0) {
>   			error("cannot open %s: %m", filename);
> -			ret =3D 1;
> -			goto out;
> +			return 1;
>   		}
>
>   		if (all) {
> @@ -168,8 +166,7 @@ static int cmd_inspect_dump_super(const struct cmd_s=
truct *cmd,
>   				if (load_and_dump_sb(filename, fd,
>   						sb_bytenr, full, force)) {
>   					close(fd);
> -					ret =3D 1;
> -					goto out;
> +					return 1;
>   				}
>
>   				putchar('\n');
> @@ -177,15 +174,13 @@ static int cmd_inspect_dump_super(const struct cmd=
_struct *cmd,
>   		} else {
>   			if (load_and_dump_sb(filename, fd, sb_bytenr, full, force)) {
>   				close(fd);
> -				ret =3D 1;
> -				goto out;
> +				return 1;
>   			}
>   			putchar('\n');
>   		}
>   		close(fd);
>   	}
>
> -out:
> -	return ret;
> +	return 0;
>   }
>   DEFINE_SIMPLE_COMMAND(inspect_dump_super, "dump-super");

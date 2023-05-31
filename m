Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F97179BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjEaIPb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjEaIP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:15:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BCF93
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685520922; x=1686125722; i=quwenruo.btrfs@gmx.com;
 bh=7r92nJr3l319aWuuu2XIAEgv12ovRYt5ownNq/jE3Ik=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=M+VgonGga7FGlQhweNGkDYmJiEu+E0egE3/klX/mfe0utlO+YWyMSACk9XqhdG8RCGpJ13y
 PQdxj1W3zRRqcrjtE0XYtmno9pT8/uhCz3TBDRCdG2lzOsK7MLeKb4X5UY5RJ4KS+IHrwBLJ8
 WEr0MCxoEL8xMQQGqVUk7PSYJz+6b1T9ae09LrOncuqcCbNUCntR2mzlyarDraVgoJL4yafQr
 znTllbeDuTDJkN27GfQPzEeO67ctvbNhV27gU9t8K1iv+tpSEt0PERXYujLE5XcEkaHxxXAya
 lsZaXZtHnMj4kOcy5fd+WrYZbTNLn+n9KU1F28wlto04JxYmhM0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1peoiq44th-00U4Tf; Wed, 31
 May 2023 10:15:22 +0200
Message-ID: <636713df-371d-0937-4a83-99df828739e3@gmx.com>
Date:   Wed, 31 May 2023 16:15:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
 <f9d3d5feee3ddd2ddf8484396b6e0642b7ff5f91.1685519856.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f9d3d5feee3ddd2ddf8484396b6e0642b7ff5f91.1685519856.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:umhSdNoBMUkXfLzxR1AZCQtnXCaoohYeYk0VQpsnTQoSFYpLI+M
 wQPjmuynABtwXSGSfFwAWu6obYmVc0csjAQWdczUnLh03A4WsMp+lvSVtHYe3BjFz/rLqIy
 cJZvguCiXRReJQ/YPpA+yYgOtQpx72LabO4BhH+fr7hLegyz+tu3XYlejs2HqHKknmjIUZv
 ooZVsYpyG8ej3ElGpxFag==
UI-OutboundReport: notjunk:1;M01:P0:pcKf/t7aSe4=;Pd4WhK6p5QfSRtSDcoLexfmrNMx
 /5jCqjTmypnG7zCyg4cQibYQ8blWEQZkIUYLR57myNRE2JfDkCZMX9G+YIEyo8iQtzISsXhxg
 WAtt0TqoK5LQj2VQ8pdamKzOfDIj0tvQcU1/enVOlcf++5VimXjFqDGTkFzmjZ6qyefxanJET
 zfGcjpb71Bp44Ld5ZxAUGe8sBpJV+OLy1DP1XV64ILjcOqxzGMJMAHN09MnNiDzMqEk8r26Gv
 5Y7WkstYdcs9FSv0ZvnM4Xiu9zyuXW9cIj5z9Rd2c0j+dvI+Ww9/R/NcRWW0IW/pMnU1COrF3
 ApfPGYadzRApKbnGaQdc3P6NaJAhkrmGx1IkwKQSO1dZBapiZwA5HkqE/J1efoYAyPGDwI41U
 tNGugs5XJhZVm6YhC1f4F/WQhN8lvN/0+kvG0u+C+RC2wzApojrSoBv2fnH4reyxgF+nzJ44/
 SH8V4RgxgHpFvyBuFB/llXb1by9fhFyD86nwvZLelvyyLqSpR2DnOwBF0LX1arUu3dlxtro2P
 J/hah9PJB4kjPk3BLcQV8uIaA1MvL2uSM3WBRv7JTWKiXLbn3zwONz+vKAbBw0kdX35EI3bVY
 W4S2i76U+Xg2O4iS2Qw9oggFnifoVfp7JlFugvG3teDGGyRox6bbFhgJiWl2dIiXwVFFesAiG
 YlEZgHtkZs4WJy/eNt9IXxwj0MpvAoeh9b5nYN+deVvvSnFALFdSKTWKbw7HKuqoh2fPDciNw
 ycl9Q8HR3CMP5WSABf0eBwvITItiiHST/IucPYP2Do52OKhHWYNJNnSb9h2iHbA3rlnPy8A/r
 XyuE2sRMd3LU0CGXTZHOfjsMeGeN7jQKhcZMed3c6YiyfytTEkfSz1WRD1BOLvzU3rShE0Yz5
 XSQs/4vtgA60DzRRzHJoZDiKRKM7lnjfQDjQj018gQqjK+sxlz6/6XjuWXufVm9HxDWcL04nj
 2UBuRJvElDfdBomxbKlmYMjk9/4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 16:06, Anand Jain wrote:
> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
> print-tree.c and to the BTRFS_SUPER_FLAG_SUPP, so the dump-super prints
> the flag name instead of unknown.
>
> Before:
> flags			0x1000000001
> 			( WRITTEN |
> 			  unknown flag: 0x1000000000 )
>
> After:
> flags			0x1000000001
> 			( WRITTEN |
> 			  CHANGING_FSID_V2 )
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v2: Include CHANGING_FSID_V2 in BTRFS_SUPER_FLAG_SUPP now in this patch.
>      Update change log.
>
>   kernel-shared/print-tree.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index aaaf58ae2e0f..0f7f7b72f96a 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_arra=
y[] =3D {
>   	DEF_HEADER_FLAG_ENTRY(WRITTEN),
>   	DEF_HEADER_FLAG_ENTRY(RELOC),
>   	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
> +	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
>   	DEF_SUPER_FLAG_ENTRY(SEEDING),
>   	DEF_SUPER_FLAG_ENTRY(METADUMP),
>   	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
> @@ -1730,6 +1731,7 @@ static const int super_flags_num =3D ARRAY_SIZE(su=
per_flags_array);
>   #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>   				 BTRFS_HEADER_FLAG_RELOC |\
>   				 BTRFS_SUPER_FLAG_CHANGING_FSID |\
> +				 BTRFS_SUPER_FLAG_CHANGING_FSID_V2 |\
>   				 BTRFS_SUPER_FLAG_SEEDING |\
>   				 BTRFS_SUPER_FLAG_METADUMP |\
>   				 BTRFS_SUPER_FLAG_METADUMP_V2)

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6350A73F880
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjF0JQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 05:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjF0JQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 05:16:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B5FD
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687857375; x=1688462175; i=quwenruo.btrfs@gmx.com;
 bh=kNYzGC/9xpYHzXVEIPdyQiOEUqTx/mEuFasxYhDKy5I=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=eIbaGqMyReek9iVX50TAdWddKmfhHT6hWZteVV8AAGW+y2dmEZDojNlD0RQ/zE8d5oxrWPz
 Pga7MAEQ6w1ITFyzv+E1rdK+uCfarmoYmGVlO1pPjeaxSWV+/O7TanihXxTO1OnUQgm3b1cpu
 wg0BN2APcMuUFu8kghWu29y+4YImwMYPqZp/o072m1kSdDM3U1mzRzSjMHg+UBipMo4/v6o5s
 /Tz6TzQR5SvRH1YfWP5yrSdvKHOlKDKCCa8hYeQOiRAN3mqGjf84X8MSANZlQePH58SXRl7eP
 1TBh5RPbR1ZRFBZ8WsBuRTW6wrxmkT1gSa0Rt2HIfbuophUoitHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDou-1ppoiU3Bma-00xdra; Tue, 27
 Jun 2023 11:16:15 +0200
Message-ID: <0f0b9a79-ef9c-e08f-1d3a-3ae66e2b04ac@gmx.com>
Date:   Tue, 27 Jun 2023 17:16:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] btrfs-progs: dump-super: improve error log
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1687854248.git.anand.jain@oracle.com>
 <d9fb113f645e6c882041aea91a356ec3a36c2240.1687854248.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d9fb113f645e6c882041aea91a356ec3a36c2240.1687854248.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dGkgx1+FyNmkP7fNxqKu5b88/4aihmD0HGXGUzHGQ4IN4ZpzT1b
 cJ1uFFE81IJ4hWcFUdYqbq3l+7rJrTTnYZIWZBzuZzk2YMly/R52OH96Q/q5knwybfvr4vF
 lO2ZdlGuy1TubsmgE2zK/NUTMdINmOpQlbJxRrdpc73Gzs4OZ96qhHVrNptd5dy4kU8Mf0V
 NnNPwQX/Z/tw7KIZBjIAA==
UI-OutboundReport: notjunk:1;M01:P0:K8qdx9G0Gs0=;6SnFj4f8wWgmSE2TTQS1o15rUYg
 oPZKskIBVI7lWL0ofbLH8X3dSC/dlGFAMg92L+Wb4CVIXGx0Tw4ImikPXes71JskT+eAhvoU9
 23qdagiCuIDs3YEUMxpIasR1DU87FU6fcgQSZnCYQnFDjafg6wUEDS1ZqEMylaTbB7A2bME7z
 yHjUB+qNdm0/L//M+53OwRM7kppncO0jtOXJXK/6oq3wmpX2YlVbMrqEw53A1GhnhfmChTZuV
 ncDRHZ9+G7HgSDalEsnhLs61yXSl8CMHyG0WF7m6KbKIeIxDddlfPkKaQIlOuuChmItI3WlFo
 rytzGkOiTz6xFbSLr7YzSZK/jNqACXe+uVCitnT6IK2RdRqe1UI0LeHTUZM+t+D6TTfCeQRAF
 FEmJZSa+Dbj2tY+5E6kv50DrR84ZAE7O36Gik9XSOjAA3nTQclKJ90LuatL+qbmTuy8P8Nzl1
 /boPyxasnYOLBDCXE2ykH00zif3uFeqfGZIze59ekpkw5du6BCtDKcj8CDLS5M6x7EjfkiR5U
 glO3bWAL+ndYq2r/WSjBG+CuZQCnQRUPVS2Z/CXZFje8CqmAb/nXRaScUON1SnLMtJqYDRk/x
 omqwdrlitWmlKOSnXJi76G1zq11OT3oQ37U1qoa4Ss43GF/gOWpZoTq4WRHkQoOxWynXjD5mk
 VAsFsyuHBrUIAs2YMZ+Z6Ly+LeunibzZhx1IQFJFCF+v8kqPlSlLxMJ5TJVNSis8MtZHVes0p
 TqI/m+cDOhiP41adrNv9qm8+ZK+o8pglGSByHCW6rdaH6uvyIVC5+HoswODSKZVPxJCGHi+j/
 vDkaz8I3HnsaTldUL8eBTPF1CTiX++Oo/0Ykbt3G0OmatLs5ghLhzTdtIUKQgsKD1wMH6n4oI
 GOir8wAsqP59QHxAnpr3AvfZJ41mAIIyeyGK+IhloEtTegSnWZCoPUJTvqmT7kluFvABD6TK6
 tKDfVDxl4igBqKBU4jIBgm34f5Q=
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
> Add more error info to help debug.
>
>    $ ./btrfs inspect-internal dump-super -Ffa /dev/vdb10
>
>    Before:
>    ERROR: failed to read the superblock on /dev/vdb10 at 274877906944
>
>    After:
>    ERROR: failed to read the superblock on /dev/vdb10 at 274877906944
>    read 0/4096 bytes
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/inspect-dump-super.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index d62c3a85d9ca..4529b2308d7e 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -41,7 +41,8 @@ static int load_and_dump_sb(char *filename, int fd, u6=
4 sb_bytenr, int full,
>   		if (ret =3D=3D 0 && errno =3D=3D 0)
>   			return 0;
>
> -		error("failed to read the superblock on %s at %llu", filename, sb_byt=
enr);
> +		error("Failed to read the superblock on %s at %llu read %llu/%d bytes=
",
> +		       filename, sb_bytenr, ret, BTRFS_SUPER_INFO_SIZE);
>   		error("error =3D '%m', errno =3D %d", errno);
>   		return 1;
>   	}

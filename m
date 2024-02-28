Return-Path: <linux-btrfs+bounces-2875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FB86B526
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C0728C3D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42843FBAC;
	Wed, 28 Feb 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1YNkssN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273A1E514;
	Wed, 28 Feb 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138335; cv=none; b=qB5sIVYyIdzFG69/tOC8FkKLrb4ajrEJxa8KRr146MKWsDgFdLpk0IXDh6UXQ1zycJameiZv9ex4stKI2oApguXkYHZr7++F0Pc0g+IUEb6ULkNq61XinJUb1zwzBqJ6kjT1r5KT3hiUDJ4LS2/I3um+9VdRzkhHMPrLzW1Osbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138335; c=relaxed/simple;
	bh=y5V4yf+OL0T4yXvoaoiubpwk4H7Ml9DAq0xONX7D8YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReBws46EZuvwnmEvBQxwg00R2gXp3Iw2pXcQHPrF3s1+0eE2Oi3nLpLOur9lsIYcIbZSK6IvciJEBXAEMXT2e6qOUSSSH3C62aUnvK5OyaJ+IUcnmNchOfdC1qNlIyHALWZ7Kz5goQ9cHl7cl2Tac90IyB4TTEG9F1c0639wNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1YNkssN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608ccac1899so53891107b3.1;
        Wed, 28 Feb 2024 08:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709138331; x=1709743131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTwj7YTldw7xXwxIUCBnkzOCQU6UVFcauswdy14IwOs=;
        b=H1YNkssNOo1yu/1vcIcK80aG7rNgNWzr+9mPF7ktCXckf7hJrgJPLXfRuGGpNT0qzG
         WwMZT9FI8llnsH+fXMLR0fnw6v+B9tJS9IUcBTHnS+qjGLkai49u54kfEfEfiUVBrLec
         qEJiWdvljcoMCM8CvFyJ5wNzoVEQXXB2f4ASvQ23X5lp64LtNq9OKcAZTGVpDGKqwUCf
         bdk0MqREcIz6tsakAEVJ6nL8JgZA6ZHBJRNVavDFsm7KvEvraF4Uu6Ar7nPYmUwOWi9A
         43IVmQlolZ1WpGSzySwk4bK5rox9co6DbIpnWTwmPF9OC82LZ8ril1weKzYf2jEYrg5g
         rhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138331; x=1709743131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTwj7YTldw7xXwxIUCBnkzOCQU6UVFcauswdy14IwOs=;
        b=NB4G+qG/N9QoHgnCtyim2m9MEwBjL549hlshANnRzOOkbMObByvZ0Swsd/zVIyyoIf
         4uAr/kRLoKqlGFujep+WCpWZWHb0q1O4hTpHQK0zjprKw8KVFC/T3O3oanaxzFZo9S+g
         oE5c1wNs3SmiFUQmXeP2znkFdtlsF/WNlZyMfo+zzAYBLtesgv7MXDJV2eArDswwXghH
         2+gXwMjTn3qCkmOXuvSKq2oH9xidvS27Afvps87W9Yg4KeCPIvAbHr2nCU70asC5EUlr
         Q+NWq4Qs4CiguSoBlaN9151pISg5EaNYRnBQijuuQlZ4xp7DTsL3mqHhIQbYXkN54WIs
         Dg7A==
X-Forwarded-Encrypted: i=1; AJvYcCUTnXBeGT87cF6zYM30XnLrOjlQnAHd/2OhYrNrePfHWo5xyEm18QRqGl/CP3Tv4Fasi1/yHWQa1/pTxhJnwn1e8u7Bt8GS0GdNKFvEbox3loQpeszw26fisl6ryd2+h+juigZhQJl+CXp6hw5/qfgxIdEqnd+UTIdOXQnqbbj9Q/mmuDQze2w5m6yc/rWY+YZzsr8saXOEFmOzPMmM
X-Gm-Message-State: AOJu0Yys2wk+DYsLAlUA/2ZgAisd3qKrXUIbm45u/81zAbJKsNsL83jf
	Q3LUPwU/g2R75nu0g7HI3/rZ4neDMHyyCd6xJxfDRqItmZ1Gr0Bo
X-Google-Smtp-Source: AGHT+IEmMyjbt5zC8HyXDYsAM1yJB6Hewc/4Omte77HBnj8s9sJO3KwuLiGqZsA5Zf/LE6Xx1smxaA==
X-Received: by 2002:a81:e349:0:b0:608:d188:6fd9 with SMTP id w9-20020a81e349000000b00608d1886fd9mr5562117ywl.33.1709138330762;
        Wed, 28 Feb 2024 08:38:50 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id y130-20020a0dd688000000b00608a174f00fsm2468913ywd.55.2024.02.28.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:38:49 -0800 (PST)
Date: Wed, 28 Feb 2024 08:38:49 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com, ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 17/21] lib/bitmap: add tests for IP tunnel
 flags conversion helpers
Message-ID: <Zd9hmZaMIcip4ndA@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-18-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-18-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:12PM +0100, Alexander Lobakin wrote:
> Now that there are helpers for converting IP tunnel flags between the
> old __be16 format and the bitmap format, make sure they work as expected
> by adding a couple of tests to the bitmap testing suite. The helpers are
> all inline, so no dependencies on the related CONFIG_* (or a standalone
> module) are needed.
> 
> Cover three possible cases:
> 
> 1. No bits past BIT(15) are set, VTI/SIT bits are not set. This
>    conversion is almost a direct assignment.
> 2. No bits past BIT(15) are set, but VTI/SIT bit is set. During the
>    conversion, it must be transformed into BIT(16) in the bitmap,
>    but still compatible with the __be16 format.
> 3. The bitmap has bits past BIT(15) set (not the VTI/SIT one). The
>    result will be truncated.
>    Note that currently __IP_TUNNEL_FLAG_NUM is 17 (incl. special),
>    which means that the result of this case is currently
>    semi-false-positive. When BIT(17) is finally here, it will be
>    adjusted accordingly.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

So why testing IP tunnels stuff in lib/test_bitmap? I think it should
go with the rest of networking code.

> ---
>  lib/test_bitmap.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 4ee1f8ceb51d..270afc0cba5c 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -14,6 +14,8 @@
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  
> +#include <net/ip_tunnels.h>
> +
>  #include "../tools/testing/selftests/kselftest_module.h"
>  
>  #define EXP1_IN_BITS	(sizeof(exp1) * 8)
> @@ -1409,6 +1411,108 @@ static void __init test_bitmap_write_perf(void)
>  
>  #undef TEST_BIT_LEN
>  
> +struct ip_tunnel_flags_test {
> +	const u16	*src_bits;
> +	const u16	*exp_bits;
> +	u8		src_num;
> +	u8		exp_num;
> +	__be16		exp_val;
> +	bool		exp_comp:1;
> +};
> +
> +#define IP_TUNNEL_FLAGS_TEST(src, comp, eval, exp) {	\
> +	.src_bits	= (src),			\
> +	.src_num	= ARRAY_SIZE(src),		\
> +	.exp_comp	= (comp),			\
> +	.exp_val	= (eval),			\
> +	.exp_bits	= (exp),			\
> +	.exp_num	= ARRAY_SIZE(exp),		\
> +}
> +
> +/* These are __be16-compatible and can be compared as is */
> +static const u16 ip_tunnel_flags_1[] __initconst = {
> +	IP_TUNNEL_KEY_BIT,
> +	IP_TUNNEL_STRICT_BIT,
> +	IP_TUNNEL_ERSPAN_OPT_BIT,
> +};
> +
> +/*
> + * Due to the previous flags design limitation, setting either
> + * ``IP_TUNNEL_CSUM_BIT`` (on Big Endian) or ``IP_TUNNEL_DONT_FRAGMENT_BIT``
> + * (on Little) also sets VTI/ISATAP bit. In the bitmap implementation, they
> + * correspond to ``BIT(16)``, which is bigger than ``U16_MAX``, but still is
> + * backward-compatible.
> + */
> +#ifdef __BIG_ENDIAN
> +#define IP_TUNNEL_CONFLICT_BIT	IP_TUNNEL_CSUM_BIT
> +#else
> +#define IP_TUNNEL_CONFLICT_BIT	IP_TUNNEL_DONT_FRAGMENT_BIT
> +#endif
> +
> +static const u16 ip_tunnel_flags_2_src[] __initconst = {
> +	IP_TUNNEL_CONFLICT_BIT,
> +};
> +
> +static const u16 ip_tunnel_flags_2_exp[] __initconst = {
> +	IP_TUNNEL_CONFLICT_BIT,
> +	IP_TUNNEL_SIT_ISATAP_BIT,
> +};
> +
> +/* Bits 17 and higher are not compatible with __be16 flags */
> +static const u16 ip_tunnel_flags_3_src[] __initconst = {
> +	IP_TUNNEL_VXLAN_OPT_BIT,
> +	17,
> +	18,
> +	20,
> +};
> +
> +static const u16 ip_tunnel_flags_3_exp[] __initconst = {
> +	IP_TUNNEL_VXLAN_OPT_BIT,
> +};
> +
> +static const struct ip_tunnel_flags_test ip_tunnel_flags_test[] __initconst = {
> +	IP_TUNNEL_FLAGS_TEST(ip_tunnel_flags_1, true,
> +			     cpu_to_be16(BIT(IP_TUNNEL_KEY_BIT) |
> +					 BIT(IP_TUNNEL_STRICT_BIT) |
> +					 BIT(IP_TUNNEL_ERSPAN_OPT_BIT)),
> +			     ip_tunnel_flags_1),
> +	IP_TUNNEL_FLAGS_TEST(ip_tunnel_flags_2_src, true, VTI_ISVTI,
> +			     ip_tunnel_flags_2_exp),
> +	IP_TUNNEL_FLAGS_TEST(ip_tunnel_flags_3_src,
> +			     /*
> +			      * This must be set to ``false`` once
> +			      * ``__IP_TUNNEL_FLAG_NUM`` goes above 17.
> +			      */
> +			     true,
> +			     cpu_to_be16(BIT(IP_TUNNEL_VXLAN_OPT_BIT)),
> +			     ip_tunnel_flags_3_exp),
> +};
> +
> +static void __init test_ip_tunnel_flags(void)
> +{
> +	for (u32 i = 0; i < ARRAY_SIZE(ip_tunnel_flags_test); i++) {
> +		typeof(*ip_tunnel_flags_test) *test = &ip_tunnel_flags_test[i];
> +		IP_TUNNEL_DECLARE_FLAGS(src) = { };
> +		IP_TUNNEL_DECLARE_FLAGS(exp) = { };
> +		IP_TUNNEL_DECLARE_FLAGS(out);
> +
> +		for (u32 j = 0; j < test->src_num; j++)
> +			__set_bit(test->src_bits[j], src);
> +
> +		for (u32 j = 0; j < test->exp_num; j++)
> +			__set_bit(test->exp_bits[j], exp);
> +
> +		ip_tunnel_flags_from_be16(out, test->exp_val);
> +
> +		expect_eq_uint(test->exp_comp,
> +			       ip_tunnel_flags_is_be16_compat(src));
> +		expect_eq_uint((__force u16)test->exp_val,
> +			       (__force u16)ip_tunnel_flags_to_be16(src));
> +
> +		__ipt_flag_op(expect_eq_bitmap, exp, out);
> +	}
> +}
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -1428,6 +1532,7 @@ static void __init selftest(void)
>  	test_bitmap_read_write();
>  	test_bitmap_read_perf();
>  	test_bitmap_write_perf();
> +	test_ip_tunnel_flags();
>  
>  	test_find_nth_bit();
>  	test_for_each_set_bit();
> -- 
> 2.43.0


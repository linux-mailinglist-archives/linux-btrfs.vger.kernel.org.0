Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD46C5A62
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 00:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVXbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 19:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCVXbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 19:31:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E542D63
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679527900; x=1711063900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q9SHaaGc/iP3oUCDDkuobziv3fI8u5euiS4kcHH3kx8=;
  b=q0jI5mXQr/arP2vSPzmxZavpeKNWba+5EFBe8ijAr4zxf1IWPVBQGdZQ
   IYlscgu/NT8uVe9Z0/is9uDt94FaAz2du7nVVi27yJ/Aj2/+el+2+42cl
   TlzR7Fw1ce7t+PesirhFvNA8d1g+RRrR/UFiIgyOprOGe3ts6IMF0dwJQ
   18Y6aJPyeB7EN2NJ1KkhPMmRuLtkRpCqVyXXkLRooZZRWgFf5CVK+d9FT
   /Xcy93IuITjkPE6HNOXzEGO5S389gxPO2ieHADzMxE6dvPlJ4AjSo3gk2
   oPBgl6iDeroxF2GGwDn0T42f/4ZsrZLtNj5rLaU/IypH5Bnpdfz3Tp31l
   g==;
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="224559250"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:31:39 +0800
IronPort-SDR: QdkjuMo7nsluVTFQZm358jXrT/v+hWk1mJWB78vNalty4MdkjP7/b6igODMd8nQ3KhJ7FCmxSs
 pJ9d7H0FfF+NfrPv4ArAEb163EeM9VIKqmfPfMw4q5dwKMg75qwr3F/Y+of/xnrBBJb2bNPbWk
 nugicRkW6nYBkK80or7QJUALNYYgapxk7iHQtcUMx1xsnAcbyt2k/pMI4Kxho22fzezkFph5Ym
 BnWyxRMPY+IWB/JsrwvKLIo7VnTQ2nHRcM1hAKRAhbPRrjhjpRcs++vmGEDe5noRW5+HJS38Pm
 4n0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:47:56 -0700
IronPort-SDR: Ay36mGqYuQF9hxsfNAMYBdxGIrUqhuUwP4Q3X2dnLcNh3MF9POSJfRtbzN1qb5fZYlWx/qB3zX
 9wwAOzFDzXFmKB3e+TA1x9tIuRGLOHaRI4CDrR5fr5z+Lfk6HynlYWjE4G4XQEFkPjWuZ4iAN1
 6JhucfXQxhErX5iHrPwCFgd2Hc3b/jbAvH6txebFoHMr8tNIMzkQg7/cEYUeAXcHHLSRunZUoE
 EWWLEDLNz7q5UG46OHJl/e/gisokOXCpGSyPY4AP+3NCkqGiwNyXuZsWQE7XGoRBgKrtHKjDw4
 AuE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:31:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Phl9Q2kSjz1RtW4
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 16:31:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679527897; x=1682119898; bh=q9SHaaGc/iP3oUCDDkuobziv3fI8u5euiS4
        kcHH3kx8=; b=JGNufdCwdGSw+94EX16K+0u2kFMVp2NvMLIq1nJZeab8uhMdwEp
        ofeBGEWeT3XCiWuOQ9cadh1ZCGt6neqeNZZyT2OBS+H2o1Cvu5cncPD0EDzjH1AD
        myqHohfVKhmuEzn/VGtFJ7tfYD8TReeVYC7gO1HyzUKJhYf0JQ75JgZThXcZk9KL
        CPRoJq87xivOlYq6xPGnJMI9lRYbH4wI6+ISXQTY6SIHsRlxQ7o3g3F5XwT9hVKt
        fLnDy4FDSd0EN1mp9Ihw418Ej9XwY+ZX1tAKbEbdvAyv0qiLal1fF184rj8UhwDY
        6eTC3LRkgdQnQyirrpmiYNHdXAQDoGEBDdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JUQKnumMLUWU for <linux-btrfs@vger.kernel.org>;
        Wed, 22 Mar 2023 16:31:37 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Phl9H74fjz1RtVm;
        Wed, 22 Mar 2023 16:31:31 -0700 (PDT)
Message-ID: <5e7e8187-f514-c65e-2615-26762a329590@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:31:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230322165830.55071-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165830.55071-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/23/23 01:58, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -convert to inline helper
> v2:
> -add kobject_del_and_put() users
>  include/linux/kobject.h | 13 +++++++++++++
>  lib/kobject.c           |  3 +--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..e21b7c22e355 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -112,6 +112,19 @@ extern struct kobject * __must_check kobject_get_unless_zero(
>  						struct kobject *kobj);
>  extern void kobject_put(struct kobject *kobj);
>  
> +/**
> + * kobject_del_and_put() - Delete kobject.
> + * @kobj: object.
> + *
> + * Unlink kobject from hierarchy and decrement the refcount.

Unlink kobject from hierarchy and decrement its refcount.

> + * If refcount is 0, call kobject_cleanup().

That is done by kobject_put() and not explicitly done directly in this helper.
So I would not mention this to avoid confusion as you otherwise have a
description that does not match the code we can see here.

With that fixed, this looks OK to me, so feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> + */
> +static inline void kobject_del_and_put(struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +	kobject_put(kobj);
> +}
> +
>  extern const void *kobject_namespace(const struct kobject *kobj);
>  extern void kobject_get_ownership(const struct kobject *kobj,
>  				  kuid_t *uid, kgid_t *gid);
> diff --git a/lib/kobject.c b/lib/kobject.c
> index f79a434e1231..e6c5a3ff1c53 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -876,8 +876,7 @@ void kset_unregister(struct kset *k)
>  {
>  	if (!k)
>  		return;
> -	kobject_del(&k->kobj);
> -	kobject_put(&k->kobj);
> +	kobject_del_and_put(&k->kobj);

Nit: You could simplify this one to be:

	if (k)
		kobject_del_and_put(&k->kobj);

and drop the return line.

>  }
>  EXPORT_SYMBOL(kset_unregister);
>  

-- 
Damien Le Moal
Western Digital Research


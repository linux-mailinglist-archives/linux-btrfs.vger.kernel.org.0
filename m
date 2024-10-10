Return-Path: <linux-btrfs+bounces-8809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35616998D4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B771AB2C3EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE861CCB2D;
	Thu, 10 Oct 2024 15:49:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C736FE16;
	Thu, 10 Oct 2024 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575367; cv=none; b=SEXD7r3Gi+np2N+smYlVaiP1mOJaOUXNgY53c45g8yPfbzJ71slSr9HkUvDrYisO59gz6XpHAiO55KOnPW9i8yb7ggizR6eF+LVPwQ0gzD0F2XnrP66c6kBPWxqqoH7C4OVo5jJA1zu2Rzx/V6v1Ws+0cVcnLnvSBMuBp4pT52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575367; c=relaxed/simple;
	bh=4if/+AC5zfdaW9hX01DiAjIH7LjMn6PrGXqZ+pXc1v8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmiT/x03zyBQhpn7bA3At5J69vgSH2THUvIHJRKNXUu/GBAZOUzAzl/vUYgSe3y8wGpn2qHAh5LHXObMbaTXAET3E/NyGgVRdztf6QxW5kfCWX6uQ83RUDwfnyGUfhWbLr52h5nCQgYvvmmzLaz1MS1npO98LoyvUrxAkQ1z4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPZ0K5GkZz6J7DR;
	Thu, 10 Oct 2024 23:48:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D3CD140A36;
	Thu, 10 Oct 2024 23:49:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 17:49:22 +0200
Date: Thu, 10 Oct 2024 16:49:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 27/28] tools/testing/cxl: Make event logs dynamic
Message-ID: <20241010164920.000017d8@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-27-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-27-c261ee6eeded@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:33 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> The event logs test was created as static arrays as an easy way to mock
> events.  Dynamic Capacity Device (DCD) test support requires events be
> generated dynamically when extents are created or destroyed.
> 
> The current event log test has specific checks for the number of events
> seen including log overflow.
> 
> Modify mock event logs to be dynamically allocated.  Adjust array size
> and mock event entry data to match the output expected by the existing
> event test.
> 
> Use the static event data to create the dynamic events in the new logs
> without inventing complex event injection for the previous tests.
> 
> Simplify log processing by using the event log array index as the
> handle.  Add a lock to manage concurrency required when user space is
> allowed to control DCD extents
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Might be worth breaking up into refactor (the static cases) and
then new stuff.

Otherwise one trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes:
> [iweiny: rebase to 6.12]
> ---
>  tools/testing/cxl/test/mem.c | 268 ++++++++++++++++++++++++++-----------------
>  1 file changed, 162 insertions(+), 106 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index ccdd6a504222..5e453aa2819b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -126,18 +126,26 @@ static struct {

>  /* Handle can never be 0 use 1 based indexing for handle */
> -static u16 event_get_clear_handle(struct mock_event_log *log)
> +static u16 event_inc_handle(u16 handle)
>  {
> -	return log->clear_idx + 1;
> +	handle = (handle + 1) % CXL_TEST_EVENT_ARRAY_SIZE;
> +	if (!handle)
> +		handle = handle + 1;

That's a little confusing for me

	if (handle == 0)
		handle = 1;

> +	return handle;
>  }




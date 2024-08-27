Return-Path: <linux-btrfs+bounces-7564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B600960DA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3510328502A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975D1C4EF4;
	Tue, 27 Aug 2024 14:32:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811181BCA00;
	Tue, 27 Aug 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769131; cv=none; b=FRJIz6cpFBYFYWe5U/CJQ5DAtESWFH6aM0fGfPTju9Ya1fVKcWyv+MI+KI+uCDzvgbxv8TundYoVoNhV1ULHo8bpaQDGu2X80PFa53d074w32Y7Kz+ahL0iLqEJDNIq4vn5nF8Anr+Am5P7PIfr3fMV7iuWeglol98jZttaGBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769131; c=relaxed/simple;
	bh=tMxRRNI4Bbc7U5SZwl7a0uHYC736X/iv1UBOz1Sa0QE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxLpIVHCZ6qEZZRfBpennG2gi78bzgsal+ccePaOiHTaOFnW23EkYRzXUbUTR6gSHHFQ5MYVq4F+/mWxqNOWGaRjdeVARsU9siTQeUYDF6og6+mR4WBBnKCV2at6o7K9noThXrQS9KkGvvBtMBAaADvUdtD5Sm8C2QfZ+ccqKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtVKG6x8mz6DBhp;
	Tue, 27 Aug 2024 22:28:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CC53B140C98;
	Tue, 27 Aug 2024 22:32:05 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 15:32:05 +0100
Date: Tue, 27 Aug 2024 15:32:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 24/25] tools/testing/cxl: Make event logs dynamic
Message-ID: <20240827153204.00002bff@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-24-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-24-7c9b96cba6d7@intel.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 09:44:32 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> The test event logs were created as static arrays as an easy way to mock
> events.  Dynamic Capacity Device (DCD) test support requires events be
> generated dynamically when extents are created or destroyed.
> 
> Modify the event log storage to be dynamically allocated.  Reuse the
> static event data to create the dynamic events in the new logs without
> inventing complex event injection for the previous tests.  Simplify the
> processing of the logs by using the event log array index as the handle.
> Add a lock to manage concurrency required when user space is allowed to
> control DCD extents
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Probably make sense to spinkle some guard() magic in here
to avoid all the places where you goto end of function to release the lock
> 
> ---
> Changes:
> [iweiny: rebase]
> ---
>  tools/testing/cxl/test/mem.c | 278 ++++++++++++++++++++++++++-----------------
>  1 file changed, 171 insertions(+), 107 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 129f179b0ac5..674fc7f086cd 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -125,18 +125,27 @@ static struct {
>  
>  #define PASS_TRY_LIMIT 3
>  
> -#define CXL_TEST_EVENT_CNT_MAX 15
> +#define CXL_TEST_EVENT_CNT_MAX 17

Seems you added a couple more. Don't do that in a patch
just changing allocation approach.

I could find 1 but not sure where other one came from!



> -static void mes_add_event(struct mock_event_store *mes,
> +/* Add the event or free it on 'overflow' */
> +static void mes_add_event(struct cxl_mockmem_data *mdata,
>  			  enum cxl_event_log_type log_type,
>  			  struct cxl_event_record_raw *event)
>  {
> +	struct device *dev = mdata->mds->cxlds.dev;
>  	struct mock_event_log *log;
> +	u16 handle;
>  
>  	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
>  		return;
>  
> -	log = &mes->mock_logs[log_type];
> +	log = &mdata->mes.mock_logs[log_type];
>  
> -	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
> +	write_lock(&log->lock);
> +
> +	handle = log->next_handle;
> +	if ((handle + 1) == log->cur_handle) {
>  		log->nr_overflow++;
> -		log->overflow_reset = log->nr_overflow;
> -		return;
> +		dev_dbg(dev, "Overflowing %d\n", log_type);
> +		devm_kfree(dev, event);
> +		goto unlock;
>  	}
>  
> -	log->events[log->nr_events] = event;
> +	dev_dbg(dev, "Log %d; handle %u\n", log_type, handle);
> +	event->event.generic.hdr.handle = cpu_to_le16(handle);
> +	log->events[handle] = event;
> +	event_inc_handle(&log->next_handle);
>  	log->nr_events++;
> +
> +unlock:
> +	write_unlock(&log->lock);
> +}
> +

>  
>  /*
> @@ -233,8 +254,8 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_get_event_payload *pl;
>  	struct mock_event_log *log;
> -	u16 nr_overflow;
>  	u8 log_type;
> +	u16 handle;
>  	int i;
>  
>  	if (cmd->size_in != sizeof(log_type))
> @@ -254,29 +275,39 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  	memset(cmd->payload_out, 0, struct_size(pl, records, 0));
>  
>  	log = event_find_log(dev, log_type);
> -	if (!log || event_log_empty(log))
> +	if (!log)
>  		return 0;
>  
>  	pl = cmd->payload_out;
>  
> -	for (i = 0; i < ret_limit && !event_log_empty(log); i++) {
> -		memcpy(&pl->records[i], event_get_current(log),
> -		       sizeof(pl->records[i]));
> -		pl->records[i].event.generic.hdr.handle =
> -				event_get_cur_event_handle(log);
> -		log->cur_idx++;
> +	read_lock(&log->lock);
> +
> +	handle = log->cur_handle;
> +	dev_dbg(dev, "Get log %d handle %u next %u\n",
> +		log_type, handle, log->next_handle);
> +	for (i = 0;
> +	     i < ret_limit && handle != log->next_handle;
As below, maybe combine 2 lines above into 1.


> +	     i++, event_inc_handle(&handle)) {
> +		struct cxl_event_record_raw *cur;
> +
> +		cur = log->events[handle];
> +		dev_dbg(dev, "Sending event log %d handle %d idx %u\n",
> +			log_type, le16_to_cpu(cur->event.generic.hdr.handle),
> +			handle);
> +		memcpy(&pl->records[i], cur, sizeof(pl->records[i]));
> +		pl->records[i].event.generic.hdr.handle = cpu_to_le16(handle);
>  	}
>  
>  	cmd->size_out = struct_size(pl, records, i);
>  	pl->record_count = cpu_to_le16(i);
> -	if (!event_log_empty(log))
> +	if (log->nr_events > i)
>  		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
>  
>  	if (log->nr_overflow) {
>  		u64 ns;
>  
>  		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
> -		pl->overflow_err_count = cpu_to_le16(nr_overflow);
> +		pl->overflow_err_count = cpu_to_le16(log->nr_overflow);
>  		ns = ktime_get_real_ns();
>  		ns -= 5000000000; /* 5s ago */
>  		pl->first_overflow_timestamp = cpu_to_le64(ns);
> @@ -285,16 +316,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  		pl->last_overflow_timestamp = cpu_to_le64(ns);
>  	}
>  
> +	read_unlock(&log->lock);
Another one maybe for guard()

>  	return 0;
>  }
>  
>  static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> -	struct mock_event_log *log;
>  	u8 log_type = pl->event_log;
> +	struct mock_event_log *log;
> +	int nr, rc = 0;
>  	u16 handle;
> -	int nr;
>  
>  	if (log_type >= CXL_EVENT_TYPE_MAX)
>  		return -EINVAL;
> @@ -303,24 +335,23 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  	if (!log)
>  		return 0; /* No mock data in this log */
>  
> -	/*
> -	 * This check is technically not invalid per the specification AFAICS.
> -	 * (The host could 'guess' handles and clear them in order).
> -	 * However, this is not good behavior for the host so test it.
> -	 */
> -	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
> -		dev_err(dev,
> -			"Attempting to clear more events than returned!\n");
> -		return -EINVAL;
> -	}
> +	write_lock(&log->lock);
Use a guard()?
>  
>  	/* Check handle order prior to clearing events */
> -	for (nr = 0, handle = event_get_clear_handle(log);
> -	     nr < pl->nr_recs;
> -	     nr++, handle++) {
> +	handle = log->cur_handle;
> +	for (nr = 0;
> +	     nr < pl->nr_recs && handle != log->next_handle;

I'd combine the two lines above.

> +	     nr++, event_inc_handle(&handle)) {
> +
> +		dev_dbg(dev, "Checking clear of %d handle %u plhandle %u\n",
> +			log_type, handle,
> +			le16_to_cpu(pl->handles[nr]));
> +
>  		if (handle != le16_to_cpu(pl->handles[nr])) {
> -			dev_err(dev, "Clearing events out of order\n");
> -			return -EINVAL;
> +			dev_err(dev, "Clearing events out of order %u %u\n",
> +				handle, le16_to_cpu(pl->handles[nr]));
> +			rc = -EINVAL;
> +			goto unlock;
>  		}
>  	}
>  
> @@ -328,25 +359,12 @@ static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  		log->nr_overflow = 0;
>  
>  	/* Clear events */
> -	log->clear_idx += pl->nr_recs;
> -	return 0;
> -}

>  
>  struct cxl_event_record_raw maint_needed = {
> @@ -475,8 +493,27 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  

> +static void cxl_mock_add_event_logs(struct cxl_mockmem_data *mdata)
>  {
> +	struct mock_event_store *mes = &mdata->mes;
> +	struct device *dev = mdata->mds->cxlds.dev;
> +
>  	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
>  			   &gen_media.rec.media_hdr.validity_flags);
>  
> @@ -484,43 +521,60 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>  			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
>  			   &dram.rec.media_hdr.validity_flags);
>  
> -	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> -	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> +	dev_dbg(dev, "Generating fake event logs %d\n",
> +		CXL_EVENT_TYPE_INFO);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO,
>  		      (struct cxl_event_record_raw *)&gen_media);
> -	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_INFO,
>  		      (struct cxl_event_record_raw *)&mem_module);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>  
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	dev_dbg(dev, "Generating fake event logs %d\n",
> +		CXL_EVENT_TYPE_FAIL);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &maint_needed);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
> +		      (struct cxl_event_record_raw *)&mem_module);

So this one is new?  I can't spot the other one...


> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&dram);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&gen_media);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&mem_module);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL,
>  		      (struct cxl_event_record_raw *)&dram);
>  	/* Overflow this log */
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FAIL, &hardware_replace);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
>  
> -	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> -	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
> +	dev_dbg(dev, "Generating fake event logs %d\n",
> +		CXL_EVENT_TYPE_FATAL);
The dev_dbg() fine but not really part of making it dynamic, so adds
a bit of noise. Maybe not worth splitting out though.
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	add_event_from_static(mdata, CXL_EVENT_TYPE_FATAL,
>  		      (struct cxl_event_record_raw *)&dram);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
>  }




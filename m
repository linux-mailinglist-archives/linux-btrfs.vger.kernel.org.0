Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864D128364A
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJENKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJENKs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 09:10:48 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE060C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Oct 2020 06:10:47 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so5874148qvk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Oct 2020 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zijgaw13geEyAuGdk+vkaVCG6cXi40DjQ5LrZnijAEY=;
        b=vt6f9uWHHD/nCeeaySp0/C65Fk4d+a6s7Pv5D/y5inOxlJ85tvsvgY7ipJItCkldBk
         Xd2AkrTrkIk5CWykkVgWf4CXCbN0tppqiT10KLWq5QE4j6hZ9kLB+2i/OzJOsiAwjEL3
         SSI29w3keOS6QSUJtay4tYYfTOs8k6762UBJ4ttxTavv/EwfGtKeXPCQPM+EGrPvAc4f
         ADko9bWCdMNDQ+ubhyDQKvUpXQ2JNrFI77IM9aIv5aanJSkvqboH2hObVaUz8LTaM+Sm
         k1oZOznSXYx+wvLZCAAHgxUn0frM8MT9U+AtRm8vWZYzT2H3HNQp4EOW+H3eGm9hMrra
         0CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zijgaw13geEyAuGdk+vkaVCG6cXi40DjQ5LrZnijAEY=;
        b=bj4qAdCowL/214QC4v60A8aR1PaKADrQEJw7iA8izKLyFZpGaQx/XwjyK2nolL2vIV
         CJ5X/1gcQyOoqYD9sCSXsAnCHJvzbIGdooo6HCnLMJbPo+Z8d4wifaQfmQ0w9cEYBSWD
         /lbv1tiLAJMJ7SYS9CD3Kdh+Q9bstIRxGbDzW2RomDXE9XGYp9Ba9FWZvFrc+1DDglB/
         c9WDWjnEvnjZN1kRRijesNjzDDG0WjdubbUFuUJ/EAJMxV5cc98eI1IZJ2FX9DQ/5UKk
         yntsh2wQtD9q0MmTdODGwsg+SUP9pdUvfupX7zZ+F0QXZjIJTQUNmo6KyXnp3nZykyjX
         WgCQ==
X-Gm-Message-State: AOAM530OCPNKrS51RJB7+J+xdZDn3J4rZdeM1EYtOLJ/bSzwYQiiOSWU
        T9omZz+8BzMVeaWDorPmr2s7lqObU0942w0+
X-Google-Smtp-Source: ABdhPJynPRs8+y0nwqiEO6dhWLoyCapbKYrNXmUehS8hNVD391yIJC93tgdv0xNgMa4ioPEIBoix6g==
X-Received: by 2002:a0c:9d04:: with SMTP id m4mr14256467qvf.50.1601903447008;
        Mon, 05 Oct 2020 06:10:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s22sm2538591qtq.78.2020.10.05.06.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 06:10:46 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Calculate num_pages, reserve_bytes once in
 btrfs_buffered_write()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200925203638.28890-1-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <91279ba8-6a8c-0295-3fe7-1c9d1affff0f@toxicpanda.com>
Date:   Mon, 5 Oct 2020 09:10:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200925203638.28890-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/25/20 4:36 PM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Cleanup.
> 
> write_bytes can change in btrfs_check_nocow_lock(). Calculate variables
> such as num_pages and reserve_bytes once we are sure of the value of
> write_bytes so there is no need to re-calculate.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

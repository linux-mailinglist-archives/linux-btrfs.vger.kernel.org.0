Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382061ECD9A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgFCKdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCKdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:33:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA441C08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 03:33:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o6so1502359pgh.2
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Xx0n0eI2Hap5RCzRZjKPDFXKgIzZ7hw2v3Tf+RcDcRg=;
        b=BhHG+ghzcpTjBgyycEAlH1uDSflmdMICWpGvu4kCgN5OL6Kq4bx46Jjvf+SvP7b/eV
         zTqO5vp7INI4OTJiCIIpm8/TyQZkV2pfEsz3IcXdNBjlZsOFicql16kZdkfsRJzPqj2n
         R0O4YDPUBAtY4ula1ZwSo2jayKub3FHszaWwABYwLxfX0AjRA12TwmR2KYg+yPsq45wn
         yIU1vpD8AGtbg3jm1UY7dsjs1j+lgOie13Vje3t+dv7xijcL0yVMWwqtfhSeLt7vjbSJ
         bXceOnzxj1CSZWfIgxFUYvglVmfQDtPfAxtb0fXUaKzcX8i6WfpLvuoGBpCtF0//gN5M
         /Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xx0n0eI2Hap5RCzRZjKPDFXKgIzZ7hw2v3Tf+RcDcRg=;
        b=G3b3QfJMtKsWufUIYBHx6IKM5VDwlTedrQ8F3UgGKkSTaXb1mgEm3U4u1LWJsj8pv5
         qMiOeAzoPLefyYwkGJF4Y3W6PuOohdVPgODu5FfuqcPGa2h6qu+HLSc6kIXOLH92vKee
         qDaJnSCQaUnxZhGVrqBmapfhwmOJXX6Is+YbGXp9Wt5/LD/KATiBmMwPZyxmeAYe4a1M
         RtmyqfK6+FnDZMIrygSsI8OBQQju+0vixRED9yG1zB+cokbimLbNa4SzpAAO0TlX9EyW
         nKMMYnlSvw74JqhZBTcaOntzIFLDxHU1o8Qk8leGcONPoAVK/HCrPwrpun+WSPpYqh4B
         ZD9A==
X-Gm-Message-State: AOAM533803HQ1mCicGClm/HCa6OPh0GB3Rwxh40Cov9FHj/j1WFxSEf2
        +L7brC2W4x0kGyU0Eq24K8CVI4q+jX4=
X-Google-Smtp-Source: ABdhPJxteySLK4XTfAkiVCXYU3/7S2i5oHl31f8TOi2Jpjm+Fa2nCiO4xLkbmW0SqfKYlj9O3vmUHA==
X-Received: by 2002:a17:90a:ad03:: with SMTP id r3mr5054983pjq.104.1591180415751;
        Wed, 03 Jun 2020 03:33:35 -0700 (PDT)
Received: from ?IPv6:2406:3003:2006:2288:b572:d48:357a:4003? ([2406:3003:2006:2288:b572:d48:357a:4003])
        by smtp.gmail.com with ESMTPSA id a16sm1380317pgk.88.2020.06.03.03.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 03:33:34 -0700 (PDT)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2 1/3] Btrfs: fix a block group ref counter leak after
 failure to remove block group
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200601181206.24852-1-fdmanana@kernel.org>
 <20200603101112.23369-1-fdmanana@kernel.org>
Message-ID: <bc6f7d36-a223-b9e7-9f1f-edd00a06ab41@oracle.com>
Date:   Wed, 3 Jun 2020 18:33:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603101112.23369-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(Except for the changelog needs a careful reading. It keeps confused 
until it is mentioned that 'out_put_group' is renamed to 'out').

Otherwise looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F581315F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFQYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:24:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41568 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 11:24:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so39898240qke.8
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f5zk3s8S/g20otjnRQfAGRA02br/oMSNcMzXIR9Idgs=;
        b=aOK471sMxAEUJJBT28rHu5v2S4haFwf1Smh33MR/CiHHiaNII6CBF8SroCLMBRAAaX
         McbtC5ghEzwMjVw9seQ4tRV7PknkQufM2HOJUIokGIi0MA0oWmMAFFdNsy5YZ85RIuBA
         dXvZKD7lgwyH6K8SzbL7luY6Y2U/O1G8aGv8PgHoecS+5wNbNTQcY6mGg56vsTgMc87B
         WvmRoDRGAaSy5mi775rCFttFOIq43Ewf7ZTYqNMwPSC4YqTI1SnODdacKH8DStdSheFd
         t1IxJrqnNYoxmaCBAsMhrx9UXSZrfQoPz7tBTDfxOHK0OX91wJO49VhSkq4N0Dd72tc4
         pg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f5zk3s8S/g20otjnRQfAGRA02br/oMSNcMzXIR9Idgs=;
        b=HPfDA5CwNqMsK/OYoSW+Z+N/3bTIfchhCssdnCKpyDQMvx4AGAAEj4q5mZrtGMhX4k
         N1aX2jZ5GdGU3trI+GMLsvId7ruch82xl5Q2k1AnwB/59qCuZPZhkJaOzFVS65Pd0J1c
         xPLkNqNTO1wxr61e633KcR2E8w6qlwxY02OANBaT8V5+yLYQORb+mTWJe9CUdrh0yLWV
         nGYX+gaFw7xHqkjoQZn27eCMcOjTG2ReVUqQzJWhJ+Q+3izQGroXJAKs9pI2iURX89Cc
         DtIfUfniFaSHD6MLLFnYTTAfSYs8Vq5rJqJmv3hOguLvSVpVwAGs3LzseD68gvQf/GEb
         81Bg==
X-Gm-Message-State: APjAAAVEW2zxwSbKgi33cPO0GU86PCJ7j1iBHCNKufY5hFxh6wny3TpC
        X98oEVK9oVJ38rdHMB/a9lI0sQ==
X-Google-Smtp-Source: APXvYqy6uU7Quw0yG+f0JUZ8hezkkgRxieVl5dRW6NyqwbpQqAjNXHDAU04t8WzoZ2Ujfc07vc42IQ==
X-Received: by 2002:a37:65c7:: with SMTP id z190mr78851700qkb.261.1578327842266;
        Mon, 06 Jan 2020 08:24:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id c8sm23478545qtv.61.2020.01.06.08.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:24:01 -0800 (PST)
Subject: Re: [PATCH] fstests: btrfs/172: Remove the dead test which we have no
 plan to fix
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
References: <20200106093427.21029-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56b716aa-51cd-343e-c9dd-2b4a186bdde3@toxicpanda.com>
Date:   Mon, 6 Jan 2020 11:24:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106093427.21029-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/6/20 4:34 AM, Qu Wenruo wrote:
> There is no plan to fix it yet, so remove it.
> 
> Cc: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

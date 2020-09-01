Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E650A259F07
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgIATNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgIATNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 15:13:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A6C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 12:13:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id di5so1058722qvb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=70NjmJLVLgjUipVfawiuWJ9nxlcI94la/P5w8czv/8I=;
        b=1hhYf1aGoOUd9EZI/Dwk5alXADlNncC8WMF8/58hl/if9j0eAhYv/QtO567s8vGvKH
         3dp5xv1I9bzt0RTI5M172a+j1D9TMnRq8/inNMxhWwtV/N+zrfKpK1AlKZMrdoAHrkHK
         bPZv01oKQj7P8GHYPqQbMK5oGtm4rp5ziAf4YOLiBIZtHIvY0lVviJJsn0ulZ4XYgVgq
         uH/jKcsVC/xE8hBHlLX1iKAaaZQXXZKvdIMcT73ioNnLBwlU05j8/yWdReIaxlW8u4SF
         rXMvbzVQt3qecVE1YDtFlA1XJcrWMkUVCghXdoHqVBt7mhPVFIIgAMfTfgEP8k8hdovL
         SQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=70NjmJLVLgjUipVfawiuWJ9nxlcI94la/P5w8czv/8I=;
        b=XkK1YfoM8LS2HLNpM0V8fWb6WkZNwdF4pIPWVLtxxf54EstSH/KG9yGp19yGmFyIJG
         jLSlYFKbWjt13t294Yi+hGJAn5LHJBQ6x6QyyOlLIQEyVgF6ozXgfWp+66qYqYewP0GP
         fbXbfYSByU4Uj9Psz+WAmA8BZhcxKjNNWPHY/XFEbhUpXyr233nbAHAP6Hi9c4XK3PwK
         EwFc4wv3PbQWBqyZxMLUQl+SO9dT6SQqC9BADYFMSGOLWygT5PrpF0qAYnhEr2zEKqYA
         yMweB3ss7u7D4+E+6J60gOQfbTBRIOwLbrI1qZ3r2lmqSc5ze45VVR7FoJUZbvtrQyGs
         oN8Q==
X-Gm-Message-State: AOAM5332+PYlQr67QVUo85MsBTK20WNPfFgwRhzcDk3mFbqWnKjomKTW
        PWmAx+XmRx+QvVqz7BEjJopme1egrxgvZKjN
X-Google-Smtp-Source: ABdhPJx+lH8qp2//Z44CRz3lki9dRHJnuavI5won+AWkylwcxLf9f7RsisxAwY6ELqDiyzAeuWoSEQ==
X-Received: by 2002:a0c:e844:: with SMTP id l4mr3522772qvo.154.1598987621059;
        Tue, 01 Sep 2020 12:13:41 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z74sm2419660qkb.11.2020.09.01.12.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 12:13:40 -0700 (PDT)
Subject: Re: [PATCH 1/5] btrfs: Re-arrange statements in
 setup_items_for_insert
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <552f71db-7fac-3ff7-b485-0fae20add02c@toxicpanda.com>
Date:   Tue, 1 Sep 2020 15:13:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144001.4265-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 10:39 AM, Nikolay Borisov wrote:
> Rearrange statements calculating the offset of the newly added items so
> that the calculation has to be done only once. No functional change.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

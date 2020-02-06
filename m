Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913021548CB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 17:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBFQGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 11:06:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44556 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgBFQGQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 11:06:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id w8so4862819qts.11
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TOpDnOmikrBXC5kmc3qaZNmORvSpErQ9QFP+CEPFlhw=;
        b=b51IzTYfP6gmr6t9CsOMS15u2gSfO4c4qm6Nh6swdEbCGBcxH/g1W0y2ax/4ca95Ik
         ObPtcQJJhNKANxgzDf8Lpzq4FLPVWfuaBx9VgeChcWFdlbbzcQKs0u55RLBby1yKCP8J
         46kkUzZK0lGMY36OEqjUPZ1Kovs30r5QAkEYR+fqev/+vdvXqpywi8aLW9TaR5oDJn44
         Uk1K5TjynT13vdZGwU40DM7aHWOvXr0mI+3h+2yEOF7rp9YJgIoXfmtRNwua4jMYUl8u
         txe3wHAKPkGqxLod9fxeNj7v3Ah8NSSzjRm502F+rBShSDZb0CQ9Dn5vyF0ZJ5+82f2b
         bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TOpDnOmikrBXC5kmc3qaZNmORvSpErQ9QFP+CEPFlhw=;
        b=bAXXqVGRpbql3EgNVB1W9AbIhU5ApnFf0LkelNmZQ/NaoTSJQoVRtO3y9vwH0F+qe1
         +ugnvZeyA78iWI1BmNjhPCZA0nrCu2ESOpnhLWakNJt3iyEhKIMwDlagTlk5bEx375k+
         QD9ylK+R26WgxcrMDLfbLVB2veqMRj6rh1q1wKTbuXXln2whfrkVlnGeN9VKksaHw5Cz
         LHxB7v8Vy7Py0sVdiVqq4eBXwlcV6xV9f7HdZ09IVh+XSWDgWRLYGzgNwk4eXkFIQlMB
         EUISgi9mqNfc3qUI+5iwJ9/Qeb8hIvs9bUab7dN/368U+9z42qB5kddDIFADOkqUmg8v
         wXBQ==
X-Gm-Message-State: APjAAAWiQfmkilayZPtv0tGIJf/xnOtOGI+7/nWP0lu+lGp/mlBecWex
        StO/WaFRq5MsIbKj/kjdhFe6pA==
X-Google-Smtp-Source: APXvYqyPfR7kSXIFxPfc4EZu+fntSUP9W0ce4lfp83zqTzhC9yI4rqOWURuVsxXIGkk23C6sPWBrEg==
X-Received: by 2002:ac8:7607:: with SMTP id t7mr3228493qtq.51.1581005173253;
        Thu, 06 Feb 2020 08:06:13 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b17sm1821889qtr.36.2020.02.06.08.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:06:12 -0800 (PST)
Subject: Re: [PATCH 02/20] btrfs: introduce chunk allocation policy
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-3-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e9a1f1c7-b5ae-dc39-c2a2-aa5bb52bd4ec@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:06:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-3-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
> This commit introduces chuk allocation policy for btrfs. This policy
> controls how btrfs allocate a chunk and device extents from devices.
> 
> There is no functional change introduced with this commit.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I'd rather see this right before it's actually used, so I can decide if it's the 
correct place/approach for this.  Maybe once I'm through the whole series it'll 
make sense, but right now I can't tell where it gets used and thus can't really 
say if it's ok or not.  Thanks,

Josef

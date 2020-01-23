Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF54146A27
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 15:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAWOAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 09:00:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44185 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAWOAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 09:00:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so3422956qkb.11
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 06:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7EDQfbwmxYzdBlVbSNZIm2j8/Pkmz17lBDRWhTEaYNA=;
        b=IQGyxPX4lI4A46Y68285aVUksWihJEO5Ye81UkBOUF+vh0ewfcDjeZhtNTdTzX0yNR
         ZJY5rCTriOR9G0GYm6LDMGQ8ytbe9H5GN0rB5gEAV9KPKF/dXzZb8oQYKTvDKm0NC6aw
         /XUt4j08Q4GCVaSAuqbgfkMvVHqSF+Pw9Q4l+OBEPVo2bOcXldL/uMRna23Cy33RUy7Z
         jsFfD84eTE0vG+KMeKCO30/KRlwBoUI2itovLk8qaBj4PWlBviNJzLww4UpvSOcfwwa1
         pt7UsMgn9L+qsdP7sZ8WW63sHZPRBuMlvIf3Uxq4o8GbbanOU6dsSbHnfuKpfdvdROZa
         yo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7EDQfbwmxYzdBlVbSNZIm2j8/Pkmz17lBDRWhTEaYNA=;
        b=DA5r6lmIBhGM7GQ+1WKJUzr0ZoeEQlCySuTu6R3COVp5nSoEhl+cjanVnttFEy/ejX
         qOxloIxrmkd6dhHDeiFkS0hunxrvN/n83rPaOx18gu/AWDndroNCwcg1pXP8xH/Eztm4
         8+r1lR8ld70ltyftSTRRBww4mDMkAnwwI9nKcWd7vbQuvp4IgqK1ZsFx6bCqtiHuPOLZ
         L2dG/Lr305hXYQIHjv4FVU6aBw52VisA+X/HfcOtBk+Vjr3leTCYrb5Ys9Ysn5gT6dlJ
         CNzZkPU66JFWdchlg5Zh0bPPP6r9A4GVPPrSnQRWRKoNE9VHYX3Z/egtJ6/gWPMNHVPy
         pDzQ==
X-Gm-Message-State: APjAAAWl+6OgJ1E1d4zC81Vkfcl9B7Jwa4p4j3UbqF9EOTnzX23G8nD6
        xsPJ4xV+bbUkY/K+krPVlVqCg6nisums+A==
X-Google-Smtp-Source: APXvYqxzFrjOJrns1Ehe8NfWA8Y8hjHnUoFrGn2XWlBCedn1NzyHXdmYF+QqbN0HxCR7MzllqaUT3w==
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr15370976qkj.262.1579788003766;
        Thu, 23 Jan 2020 06:00:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id m23sm1020239qtp.6.2020.01.23.06.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 06:00:03 -0800 (PST)
Subject: Re: [PATCH v2 4/6] btrfs: remove btrfsic_submit_bh()
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-5-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <755e254d-4b87-7da4-5cb1-d3fa4975cdb0@toxicpanda.com>
Date:   Thu, 23 Jan 2020 09:00:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:18 AM, Johannes Thumshirn wrote:
> Now that the last use of btrfsic_submit_bh() is gone, remove the function
> as well.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1E15A9A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLNEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 08:04:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42600 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLNEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 08:04:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so572429qkj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 05:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s1yFcAbf50k865toDawBCplvyBk+Id/LRJ+MzeuQEi0=;
        b=EHpUfy+K2YkdkZCrFxGUSNBiHX3zAypzvf/3Srd2uiuHT6tcbLPvwp2B3Ch18XtQdJ
         93EcTVIZDnWOhFGNzNR0ZOnqzDopnAycmsGgSkh3H/bbDel93LdvK6C2MjRvjg6cHsLW
         6xxaRjtdt5Q+ZCUjF/M+jkcBTfcof/nS31I1cbjyNdGc7nQEsrjZou86XzFS8Y/fr5Qy
         L/gqky+NEOyWku1Rl1rgaOJbMADgIOPnrRciC/OiuaKNKM6ITt+de8SGrSv2N7qk4sVy
         vf40QbBtYoadOSbQKMgUqVe0tSLxp5xKk6SaSOck2soEYzDcFHFmc6jAMiOa6JNO5M0p
         4iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s1yFcAbf50k865toDawBCplvyBk+Id/LRJ+MzeuQEi0=;
        b=ULw/UKV+Wi9eLYkWblwwBC8oDQlt8+0iSHNlyH0pZhMR/1jcn+RA/c4ZDVEcg0dIWu
         SuwpmE9CrJG9u1llwgHfCrTv0qzU7RzK6sPyzocnQxLjsSiBqc4h6FTfM/qv6Jv2ICPN
         r6MoZ1iURTK+7Xwn6H5spTUnkw/Lotg/7lXMNGLXtfFICZUdc8rCo3tMf7sFta5PAOdn
         tkQ7RJQwOG9TioOhC2FbRTWOp9wSM+ymYUtSzb/uP1+aelxFDzjMc3yawDLZtAG//cAQ
         0e70/09NFRaZOFseM0CYfbKh+rxfOjL77luq1tHPt0W30RRonOY+kf9yzFz9y5ui93Eg
         83oQ==
X-Gm-Message-State: APjAAAWTa1IORE1oeqseUGury7ObsgiTFreQjs2qPrcWYolloBpbK6Mz
        2Te6UgBbrzg5rCJeiyhohcHOor692WU=
X-Google-Smtp-Source: APXvYqz6pDQo7Azycorkq4yi+UyBbe+sGuiwaic9D/0MCP22/iTOOURcP8Z40yB37KaboDG0NVZahA==
X-Received: by 2002:a37:a78d:: with SMTP id q135mr10234657qke.158.1581512652240;
        Wed, 12 Feb 2020 05:04:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::de08])
        by smtp.gmail.com with ESMTPSA id m27sm124141qta.21.2020.02.12.05.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 05:04:10 -0800 (PST)
Subject: Re: [PATCH] btrfs: Add comment for BTRFS_ROOT_REF_COWS
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200212074651.33008-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2158c382-a3ec-1c0e-df9f-9ff6d4017b9f@toxicpanda.com>
Date:   Wed, 12 Feb 2020 08:04:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212074651.33008-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:46 AM, Qu Wenruo wrote:
> This bit is being used in too many locations while there is still no
> good enough explaination for how this bit is used.                  ^^
               explanation
> 
> Not to mention its name really doesn't make much sense.
> 
> So this patch will add my explanation on this bit, considering only
> subvolume trees, along with its reloc trees have this bit, to me it
> looks like this bit shows whether tree blocks of a root can be shared.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

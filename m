Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F159F166116
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBTPgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:36:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34225 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgBTPgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:36:31 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so2077103qvf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1a5PeabDReVjL+ppOgFqb/01v2RxQXy+S0ZctJQR6qI=;
        b=qJ8BJtfgTHw/iX0zPu1oL9v8EG+v/mxZh1m/aRh+2I1VicA6IhWxuf1birbHVIQVZa
         EvzJm2XQA7nk4Zg57hHFrsieqxyhqWtHAboZjGKd6hnzf1KGbq+rAs2pEAk7GicAvk2V
         5zyqTBbpEr7+wiSQfwB85K1/juOOmZz3/aFvE/WUiVPNXOMyajkgAZW3zbrb8/DpegH8
         XXz0JVLT5ckolpJrvvEKawxytYZTB+AhfNi5JPkN3tJYHHHyfw0H5l+JlrDgAGkJRsdB
         Jp/Gn2Vp322ndzcvm1H8lZ+m+exYbk6UkHmzmG1dtR9P4z8wRK7vpkARa6f8Y658bFu8
         STIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1a5PeabDReVjL+ppOgFqb/01v2RxQXy+S0ZctJQR6qI=;
        b=fhNOK0cC0jA531KYZLCHXreNE+55ULvb1lkaSe7aBlhTqQyM8ymE8DkLIWMttUjepc
         esbh20hzZ44xjm/9NNKVntyNC6nvBlM4mjphVEpHFYDVjQX6UMSO4xQRNubsK9hnfK6/
         xbYw3n7rszOOGm6RGI1cqZOaS6jpgKBM9ZnfaPetBOu9QbNdn7MHeNyRP1jOjzwWlH5h
         3CytRnuDXnQHWdoRttiIQNmUVXi7+az0Sg2Btes+32j59E4hwVF663MD0+3nei562sqY
         ux4RU9J13NdeoIhEQFFzw0HXpKFVisosj2QWBCQLJjTW2oXrM6Xl3upi8kRPJs/xxnf8
         heKQ==
X-Gm-Message-State: APjAAAVxbNuyVegX8CzLyKbcQwgLc7b5nxNKpCf8UqW6wmzRw6tdIVep
        JP3eX+78E8W9NOL1RAQ8xzt3N3seGiM=
X-Google-Smtp-Source: APXvYqx5DhL7xR2+o/m8SpwkJY4EmHUtTBnHwxtudokiF3IhO45ZRkWYjtRk/UScBpgXxW3QLfdOzA==
X-Received: by 2002:ad4:58ae:: with SMTP id ea14mr25383650qvb.247.1582212989129;
        Thu, 20 Feb 2020 07:36:29 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l19sm1736355qkl.3.2020.02.20.07.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:36:28 -0800 (PST)
Subject: Re: [PATCH 1/3] btrfs: Call btrfs_check_uuid_tree_entry directly in
 btrfs_uuid_tree_iterate
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200218145609.13427-1-nborisov@suse.com>
 <20200218145609.13427-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a3228fb3-fd2b-c475-3b15-6c256d268379@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:36:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218145609.13427-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/20 9:56 AM, Nikolay Borisov wrote:
> btrfs_uuid_tree_iterate is called from only once place and its 2nd
> argument is always btrfs_check_uuid_tree_entry. Simplify
> btrfs_uuid_tree_iterate's signature by removing its 2nd argument and
> directly calling btrfs_check_uuid_tree_entry. Also move the latter
> into uuid-tree.h. No functional changes.

You forgot your signed-off-by

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

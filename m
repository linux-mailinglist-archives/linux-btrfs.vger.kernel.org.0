Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD313AB44
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgANNog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 08:44:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38872 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgANNog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 08:44:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id f20so5261077plj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2020 05:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MnqGcAehX1wU5gwwiMLN+N6Z2YOiwMYW6UCijsntxno=;
        b=Htw3saGw+wHiHPek12YM321HKtvgj7SH79Ljty2vOzIg9vtFofbjUcgB4bpgPsz3m4
         siyh1yD8rWHSH/IzB5SBqxYR3QYPNnA9nqZffI+Ul+ZmPTeUtXcL27OBe+8xjkd+gPHO
         7A8Gh9sA7lzNjhVOULGU2KBAfFmmfhFUL5uWs96eNoz47B9jvZcimTNKwSx0TwHU82CD
         glLb2evg9XDBbjhvX5iXBsYZAt+H+9KEYCU0xVNQtD7M+v33jrQuxFPQ5PEesiMeijvX
         8p4lKgVuya5io7JZIaGXVa2w8XqyY23aNC03M9pxyxwkXbX6LBR4NIgGmJ2lMyVg+MRY
         S1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MnqGcAehX1wU5gwwiMLN+N6Z2YOiwMYW6UCijsntxno=;
        b=GAwFlO/2whyF2LfP2qThOrlvWFlgzEvZRyZqNdKPTKjGnZ1Y8sCjfjEhjNKY0L0uvu
         DyervQUmKD+NqeVUf8v6sSiGeEdYxCSk9BMo5f8dJpAAdRwxWWdSyiZeCMO5ebSz9jVn
         IiHSB6HOWCfR5cAc9pXyV5Zurl/hFg0DurTt8LJqcYs8h2zadOCfunyZOzFOpzI8YSiI
         Xvb0AN+47vrAuX2cl/Yx7oL5+MBzpqcDPifb5Bnp1yW2/a6jmP31rZid/NynNQu0I/7V
         YeIOrZ1GMkC7HsdFLCwixHmwvgcEq/qNZi7A6KGAUzhN1jlhGeyfM4Q88A4D2PTVko/i
         xG9g==
X-Gm-Message-State: APjAAAU9KyjugTqVkh8aNY2bxJV8uqVLNNbM/OWtwwEQSaI49R272oiU
        2VhU3NiS9j/banAXtND2MV7PhQ==
X-Google-Smtp-Source: APXvYqyKX/YY52+Dk4ut5XBvn/NDgz0FdIlhRtW3UaxpoVB0L4M+YCS2y0+YsWHIWYWWlJlRFsTBww==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr28185778pjv.140.1579009475725;
        Tue, 14 Jan 2020 05:44:35 -0800 (PST)
Received: from [10.11.6.52] ([96.68.148.21])
        by smtp.gmail.com with ESMTPSA id q10sm18994445pfn.5.2020.01.14.05.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 05:44:34 -0800 (PST)
Subject: Re: [PATCH] btrfs: Implement lazytime
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7d0eadb4-5712-6fa1-f50f-f8ea6d8aea43@toxicpanda.com>
Date:   Tue, 14 Jan 2020 05:44:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/14/20 12:53 AM, Kusanagi Kouichi wrote:
> I tested with xfstests and lazytime didn't cause any new failures.
> 
> Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
> ---

We don't use the I_DIRTY flags for tracking our inodes, and .write_inode was 
removed because we didn't need it and it deadlocks.  Thanks,

Josef

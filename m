Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3380B16E92E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 16:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgBYO7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 09:59:53 -0500
Received: from mail-yw1-f53.google.com ([209.85.161.53]:32846 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgBYO7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 09:59:53 -0500
Received: by mail-yw1-f53.google.com with SMTP id 192so8044724ywy.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2020 06:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quoininc.com; s=google;
        h=to:from:subject:autocrypt:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VehEgphwH3tpvL1qOxAQQzHjkhpQgPJSFxd68Q6rIaM=;
        b=TddFQQPmFdI0VKvF/Aoqup4FBkeEqHjnrXPG+B4KloRCpyKAse74abibu4scfKv2sK
         5PUIvm99ch2HduTHQQo6Vn0k6wwXACFFc/L13Ybag3kv11nYMW5V1u2A1h7RNJx5DDvC
         BTXDj2Uaz2Qz9RwXjaJhbw06c9snMNUTBxRyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:organization
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=VehEgphwH3tpvL1qOxAQQzHjkhpQgPJSFxd68Q6rIaM=;
        b=e/aBOxnQeBcShpwJuMVwTB2zEUVguJUy+g76PacsLAQpcC1uXbwdjF0/pNQ+vF71mq
         4UopFBQ4ioAQDN6U4yS5qQUf3RiszTAo+JTLHe04miz50Kv+8UWLYMo5YEBaZPwXhOoA
         twHTfNBSiLvNP9HnbH1G/7yvwKnsDhpmjyx5hkaFN5v82DBj/ySZJFZMivhjSQ6mdCWI
         TgU7yeXc/aDQSCLvSdpnfIvOySr4AGSzkRzX5O0ogMjxkHKCC0ds4XLsy6ckdUgLq3AI
         45E4xq9bfcSOjplr/a3TttMZm7Aj/Jk7D8tMX+YiCrgtzM9l5o/68HVXY3JwEcL59vU/
         Cpew==
X-Gm-Message-State: APjAAAXfKC/vkN4LxWGsEeaNTuYnhd6HdJVUHslRrpwXDk/CMST0Uh+4
        oHWiqXgD8eTzFjU5bq+jbf8mosN8mmk=
X-Google-Smtp-Source: APXvYqxQaSqH8GWhhLOVLyCGiPW+nQH5ZFjdM0G2d8jiTlOvPaJNrzwU1vxTytX+zyI8nOlbBAKjeg==
X-Received: by 2002:a25:bfc9:: with SMTP id q9mr7427168ybm.496.1582642791576;
        Tue, 25 Feb 2020 06:59:51 -0800 (PST)
Received: from [192.168.192.103] ([168.244.11.26])
        by smtp.gmail.com with ESMTPSA id s12sm1005777ywa.3.2020.02.25.06.59.50
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:59:50 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   "Franklin, Jason" <jason.franklin@quoininc.com>
Subject: Hard link count reported by "ls -l" is wrong
Autocrypt: addr=jason.franklin@quoininc.com; keydata=
 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
 AdlsPF403hhWS8JgqXXkPCftW5sFQ72DY2Re
Organization: Quoin, Inc.
Message-ID: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
Date:   Tue, 25 Feb 2020 09:59:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings:

I'm using btrfs on Debian 10.

When using "ls -l" to view a detailed listing in the current directory,
I get output similar to the following:

total 0
drwxrwx--- 1 jfrankli jfrankli  38 Feb 25 09:54 Desktop/
drwxrwx--- 1 jfrankli jfrankli  36 Jan 24 10:37 Documents/
drwxrwx--- 1 jfrankli jfrankli 612 Feb 24 15:48 Downloads/
drwxrwx--- 1 jfrankli jfrankli   0 Nov  6 04:44 Music/
drwxrwx--- 1 jfrankli jfrankli  20 Nov  6 04:44 Pictures/
drwxrwx--- 1 jfrankli jfrankli   0 Nov  6 04:44 Public/
drwxrwx--- 1 jfrankli jfrankli   0 Dec 27 20:20 Templates/
drwxrwx--- 1 jfrankli jfrankli   0 Dec 27 20:20 Videos/
drwxrwx--- 1 jfrankli jfrankli 522 Nov 26 09:53 bin/
drwxrwx--- 1 jfrankli jfrankli  28 Dec 27 15:23 snap/

Notice that these are all directories with a hard link count of "1".

I have always seen directories possessing a hard link count of "2" or
greater.  This is because the directory itself is a hard link, and it
also contains the "." entry (the second hard link).

Any immediate child directory of a directory also adds +1 to the hard
link count on other file systems.  This is because each child directory
contains the ".." hard link pointing to its parent directory.

Why does this not happen with btrfs?

Could it a bug with the GNU "ls" tool?

-- 
Jason Franklin

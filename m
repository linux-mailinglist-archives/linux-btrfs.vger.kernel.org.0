Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CB18BB1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCSP2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:28:51 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35976 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCSP2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:28:50 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so1214292qvw.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hxfT/XswT+2VTxIeghsZOi4UTZlWT3/1jm4g59vBQN0=;
        b=TxysEdq6stnoAixv37SuDVC9nouf3ZtJwj+uyR9nCWtfy4HIRJ1TPgxrUKLM9gPgI/
         XGyfy8feoM2mGxZbXrjYJIVAz0oc3yMp1hmTNYGRl5B94KkYh3Evkl/g949+rkg5688r
         8Ckdanq7sf6E2+9rUENdsi4voMaGdPG3fMmKs/2N8a6jaHNtiC421phNfhJ/uADZ/rY7
         klX4jMKSgSOUx4KafV5SUEGDQ6VRHLH9ZG0yffcTdX8wuKoWTLLyzoE7kdfS5cTFNIW4
         t+r7X7Rb4rJNQI0dPWF30MzRq5mkHGwijnJdTTKVPy+nSjJZdUenOzOvS0gowmE5gIp+
         DcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxfT/XswT+2VTxIeghsZOi4UTZlWT3/1jm4g59vBQN0=;
        b=t9ieWk+GNfi4zmwLfj4dZrJyw+16kHKAQshOr6RZ6kQA4gDVMSgY5Z72Fo5No7YIFq
         CAPc67uODBXcD0TC7m0PyZe67d4YCFpCGscqhB2pCQ01e9uM0ocP77MhW/S2lE/V/9zj
         Dt2F9CGli/4W1x6XB0xx61+fyYDr/0LaFkyfz4s1qOcZw6C2GYNijK2bLBTAqOOaFBBC
         dSLbRrAExpt4osoPi8GenvXVwT46id7Zn4giiLfJIs6Su8ce+mJ/+NdHwaLlb7oWRehT
         NArJVC0MZ9Z0ISlhxN1K+STp49srM5Gz0NLa9b1+WgSHi+xMRgYKthdKyM28eyen16ge
         nGiA==
X-Gm-Message-State: ANhLgQ1OiA9pdLeCjAvvKXOIW90Brrlys7bnQObHevXB1sFrdKbIaG98
        D7i+jPlQEMvgBi5b2xHJKmcepMQWFi8=
X-Google-Smtp-Source: ADFU+vtK/6KO0lVBODXW6e2mRQmJ6dC6aG8M9ZtLOgzIAbUsAVzw984FmOliTe5yXrn/QpPX7iGXEw==
X-Received: by 2002:a05:6214:205:: with SMTP id i5mr3510876qvt.223.1584631729083;
        Thu, 19 Mar 2020 08:28:49 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u40sm1739500qtc.62.2020.03.19.08.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:28:48 -0700 (PDT)
Subject: Re: [PATCH RFC 07/39] btrfs: relocation: Make reloc root search
 specific for relocation backref cache
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <caf591f6-b45c-bfe3-c017-781a979b644d@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:28:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> find_reloc_root() searches reloc_control::reloc_root_tree to find the
> reloc root.
> This behavior is only useful for relocation backref cache.
> 
> For the incoming more generic purposed backref cache, we don't care
> about who owns the reloc root, but only care if it's a reloc root.
> 
> So this patch makes the following modifications to make the reloc root
> search more specific to relocation backref:
> - Add backref_node::is_reloc_root
>    This will be an extra indicator for generic purposed backref cache.
>    User doesn't need to read root key from backref_node::root to
>    determine if it's a reloc root.
>    Also for reloc tree root, it's useless and will be queued to useless
>    list.
> 
> - Add backref_cache::is_reloc
>    This will allow backref cache code to do different behavior for
>    generic purposed backref cache and relocation backref cache.
> 
> - Make find_reloc_root() to accept fs_info
>    Just a personal taste.
> 
> - Export find_reloc_root()
>    So backref.c can utilize this function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Nevermind I see you moved this later, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

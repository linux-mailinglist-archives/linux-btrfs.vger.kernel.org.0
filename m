Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5F18BDF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 18:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCSR1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 13:27:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33729 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgCSR1C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 13:27:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id d22so2556057qtn.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SrymTl7SM6r6oRIJQOLagUG+s6nCRISs3mEMm1LnTqQ=;
        b=DyqZOrc17zrUjdCJyD2xp/j/SXFvIFilbC/ZwFARbvu247aZXJ9EtdVi2IKALZ1Yfj
         D6IrzYUuSob1/0cHhI/sYyK1GfKDYm3AEThwLKRdfWbTLjv9dt7WS+EQV8Vj/XF6UuyR
         hD3CxloObt3uZVeDQKTUJPCeE0WBEbt/vWQJDFO4RPoMN5WR/HjBvkVajq867lc2UXHn
         KZYS/s9c8HV8qwfCFdVhzn0ojyRWphN+1leAJq4vOxz3FEYz/Oexr4982sdYvZJuPmI7
         QJXS4MWb0sx8csnLdHXCjDQ9g3vqBkEphAZlmvysbCWW3UIndGtBRPlZEfRNnf8W5cH+
         lr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrymTl7SM6r6oRIJQOLagUG+s6nCRISs3mEMm1LnTqQ=;
        b=dxvAzQuVrwc9Dc7wQSMGgjIEg7n1X3rU2yY9aoqI6a9kootELlLtSIUpBU5N0FNkwT
         fDCLre9Mrgn1oV0eF4A7y03AI3yuCEcMGUc0ws1ZekihCuYU2IavZI09hqlLJ7ZUiCCg
         p+E+R/MBmGKODF1r3/MmsunqKhWns4YSi6k0ZjQPJ+XTh2qlqVvBn2P9vkGpbelVr6Eu
         Ug90Bo1LJpHvrEjjiATUVIXICogWWtMhAmG+WjW94J/vDzSbznrLiatZ+naJL6ofZ2w7
         zXCFSmHliAc9/VYl6I006zn6gUg53Bz4ytuhV5ozAXLeY3yPDlqsiPkAlV3jAitISbOA
         eaRQ==
X-Gm-Message-State: ANhLgQ07m0ZN2QocB+Aqi+Jz8QUVRx8Lyw+pIBN+kQlGK6emR00GQLxO
        YKEuWEkEWk1U6LMKNxS/Ozjm2NZUTg8=
X-Google-Smtp-Source: ADFU+vvJ6XTaRyuL+IIiqDBecESIvtaMqm5FiSaYFmNMLWbYtFcO2Nu6p43n5OinntD6OPkpDbIM4Q==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr4021496qtt.385.1584638821183;
        Thu, 19 Mar 2020 10:27:01 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x51sm2103892qtj.82.2020.03.19.10.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:27:00 -0700 (PDT)
Subject: Re: [PATCH RFC 15/39] btrfs: Move backref node/edge/cache structure
 to backref.h
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-16-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <39932872-c7d0-3b24-2646-6eccbf560209@toxicpanda.com>
Date:   Thu, 19 Mar 2020 13:26:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-16-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:11 AM, Qu Wenruo wrote:
> These 3 structures are the main part of backref cache, move them to
> backref.h to build the basis for later reuse.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

If you're going to export them I'd rather you change the name first and then 
export.  If we're going to have things in header files we should have btrfs_ 
prefixed.  I made my naming suggestions in my reply to the series.  Thanks,

Josef

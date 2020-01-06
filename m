Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B51318B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgAFT3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 14:29:07 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33184 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgAFT3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 14:29:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so32638440qkc.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fRnubx4UUoNLdwZPwYlxYjxmRpi7eKNcEjSEF84BREM=;
        b=Yu7Nd1+hwjv9M1L0YeIzpOvvJvi89ddqi2EObMk3Fq34MwTw8R5TVt/U5nnmw4rknH
         4Gspx5SIxM1FQD3bGaib+dK4dFRtnE5DjiXXC8Y622lvL6ssNpDKu4Vhbd3PBD9AwqH+
         OHQjLO/eBLPjJCWDdWkrSzask6PbEc5WoIHEaegvGB0+9se29tVvix9xejJxP3ryir12
         rrsTfU5nXgRCmEELSR6IgBQLUh3Mm2SV04iz1ZENqoQqC+i8zFK5ozYF9DlC/km5XYQg
         qiX/U/CZdsGyaZzadcBcMCHJWSsU7vXAXzgMTV69k1c/SDtsV4qjshiGw46Pt9r0Eeou
         lY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRnubx4UUoNLdwZPwYlxYjxmRpi7eKNcEjSEF84BREM=;
        b=s4rTicIiMtGDQ804e4fLlG6L8A9FIsqQk+POAS0eA9YCVyw+6YBANgwyAJMWM5EnUb
         dNw1zpGBIQ2gi/FmnmhRTmP0KeO+AMoVVnTtS9iF8Nq6OTVPJgSRJPXhmtah8amIRd4i
         a2IFPaDRME1UwvqxrTN3w/k32EMO6GfY7Pvv4WD+YMmSC6KRDQTD3Ty6y+IxtMhjvJEA
         3Gzrcva/nNPeZeY93tlEcaMwGyrIpdB0AG29uNy3Sn7Ks1I0gODGT5kJCn+Z7y3T7fo1
         D9BUWE9/U6J/pDbkrsjSKPZtkoZEzn3Z6ra21Xy0Q3UfzNP77b6nx39Q46L0WTHqr3R7
         B9EQ==
X-Gm-Message-State: APjAAAUq7d2e0OnLX9Rr8CSE8hJ7uwp498jlvmDx6jYhdlfb8A+XG/Cb
        4gBs2Lm/tEyZXrR9Y67kUloDodaV+BC3Og==
X-Google-Smtp-Source: APXvYqwWh3td5Zfy6KWUCCCLDPI+1icTtXo+ejgKi7fAg6q6Nz40HsOZ0BFnbq6uMDgEX1AL1e7CNg==
X-Received: by 2002:a37:a406:: with SMTP id n6mr86025545qke.63.1578338945899;
        Mon, 06 Jan 2020 11:29:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id l6sm21192617qkc.65.2020.01.06.11.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 11:29:02 -0800 (PST)
Subject: Re: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191230213118.7532-1-josef@toxicpanda.com>
 <20191230213118.7532-3-josef@toxicpanda.com>
 <20200106172234.GN3929@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a9b6d5cb-b3a4-8088-c6cc-236ef555cf44@toxicpanda.com>
Date:   Mon, 6 Jan 2020 14:29:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106172234.GN3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/6/20 12:22 PM, David Sterba wrote:
> On Mon, Dec 30, 2019 at 04:31:15PM -0500, Josef Bacik wrote:
>> @@ -60,6 +60,11 @@ struct btrfs_inode {
>>   	 */
>>   	struct extent_io_tree io_failure_tree;
>>   
>> +	/* keeps track of where we have extent items mapped in order to make
>> +	 * sure our i_size adjustments are accurate.
>> +	 */
>> +	struct extent_io_tree file_extent_tree;
> 
> This is not exactly lightweight and cut to the minimum needed, the size
> is 40 bytes and contains struct members that are unused. At least the
> file extents tree seems to be in use unlike that io_failure_tree wasting
> the bytes almost 100% of time.
>

I'm not in love with it either, but I don't want to invent some lighter weight 
range thingy that I'm going to end up messing up in other ways.

Don't take this series yet, there's still something fishy going on that I have 
to figure out.  Thanks,

Josef


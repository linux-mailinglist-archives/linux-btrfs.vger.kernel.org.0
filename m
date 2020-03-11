Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43743182055
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgCKSER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:04:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44837 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKSER (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:04:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id f198so2969372qke.11
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=liPp3EQar14kmD6D/Ie18KvQn3utx3XGhCfQIcS6Ado=;
        b=115SATe94S08Fotu1mrlWiiRJdsyoHLGdwMMv4M0dwaIuvq6zqjJcj4/MAvfDofeDe
         lVHRRzHG2K9FVsZ3AxuZvoh4jdwp27PYu32qz3M02nrMGYnh1nio1S+V1AaO0DJnz6qV
         3NnDOL1vhp+UWf8eptJtCmo+Ft2KG8ju/dVSJSUmMlRdmnmzptWjP0VT3zVNoUVW1WIh
         xyfMKsXS66eclWAhAsKIJ8xQ3XW1FB1Iibo7LJmYz5RZ6rf63/OL8Ia9pJChIurUVXbf
         dKgP0g8Tsc/FRT5sopUbYosP9ggPPua1GRc6H0t1EjZ64LqyzuItvnjZ9Dd+KZtoqjIo
         rFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liPp3EQar14kmD6D/Ie18KvQn3utx3XGhCfQIcS6Ado=;
        b=S4P6LrmnlksijvgjMOJDHBxJhw38XKu5wJHPfxXJSQyKobQKIHaXXaNlk0/nPPsrD0
         twnpWPPjC41G+uhYNBOXdwXY9AH9VFVHRj4qgsOIEUt5oEZKf/4uHAHLJ8F9XMjJATo2
         4oRvkW3TCAEhAwyH8pwO5pUOZxIHMcxjCL8dN7tJWFLJ9D+CJyGu33buds4hOoLA/vds
         N8Qc3719YjcCePfHrPq+Z0VRBcG7G82REtjBGN5tX9r0vEdY258InPXmGR1W2yEMi8Hf
         v4r5fVEc5Hsnc7RLkLGFklbOCDONfZsZTSKjxIasFnpz1BIwpUE7oPHt8EAhwYANnAti
         HGUA==
X-Gm-Message-State: ANhLgQ2vBuP1YD+1eZeIa4wF7zjloul99aZOSDpvWLE2uWhvtMUDmpXA
        5lqV2qP0YxrdSzSzNWliA+KV1A==
X-Google-Smtp-Source: ADFU+vtcZee6WR11KQ+ERWThnbh0+fl1EEAF+7RMVDUG1NXkqJolsuF+cSID746UHlGtp+tTlix4mA==
X-Received: by 2002:a05:620a:994:: with SMTP id x20mr3706724qkx.489.1583949856248;
        Wed, 11 Mar 2020 11:04:16 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g15sm22284558qtq.71.2020.03.11.11.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:04:14 -0700 (PDT)
Subject: Re: [PATCH 11/15] btrfs: put direct I/O checksums in
 btrfs_dio_private instead of bio
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <95b275ed47f1e4bdaba53040fe6de9eefdf3a5fd.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <97110883-d7ba-a845-6d1f-42e119e0b955@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:04:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <95b275ed47f1e4bdaba53040fe6de9eefdf3a5fd.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The next commit will get rid of btrfs_dio_private->orig_bio. The only
> thing we really need it for is containing all of the checksums, but we
> can easily put those in btrfs_dio_private and get rid of the awkward
> logic that looks up the checksums for orig_bio when the first split bio
> is submitted. (Interestingly, btrfs_dio_private did contain the
> checksums before commit 23ea8e5a0767 ("Btrfs: load checksum data once
> when submitting a direct read io"), but it didn't look them up up
> front.)
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

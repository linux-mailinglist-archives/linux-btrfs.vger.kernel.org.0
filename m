Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DE541BBAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbhI2AYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 20:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhI2AYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 20:24:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3313C06161C;
        Tue, 28 Sep 2021 17:22:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w206so719925oiw.4;
        Tue, 28 Sep 2021 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :reply-to:from:subject:content-transfer-encoding;
        bh=3fBfpbZUiy0Cf08SHflfMmWKdhfepW6n1hPlgKhvrsE=;
        b=Z0cvayyFWuaQABuVVjek0nai5Gvqz32Ds2GHxA1WL79J/ckAN8uQjCMXzugR7RIKbW
         cdXYV6qRXLIPgIYpQVcrskVxP9ml20E1ldifydaEahJc/0QgMOT43vmUNwHMYm6pPA1r
         vdcVl4X1dmnf/TI66qxtIeY/sLHy2NfhufywN2E/vcqL/L6RUh4vqsrD7MwR8o9Ldj1E
         B22Rgv5UYhqynSS1zXCcEId+HJiixOpHjQXxpAsf35UsGhMnjs8iDgldvqxSyS9xWqZr
         wfuXilXL0i1ZXd6vuX7XTDWZJ1U6xUNUrHm/agC0qqMP27Ry0vjNdAPyCSeRtL1CZX8/
         Gs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:reply-to:from:subject
         :content-transfer-encoding;
        bh=3fBfpbZUiy0Cf08SHflfMmWKdhfepW6n1hPlgKhvrsE=;
        b=YvIKEzscoptj63BGOuA1V0lvTcnecV59IbM0c8uXLZDY5ss7oGRnGDG5CAapRZ49pn
         eeKMElG8h2G6D5ZtTxxXioJjWxdMct7s9GZkmku2wC7eclId/myUbzb7swjmMRQE/73t
         GbakwoTPz336wuLn6DojJisVUURpPvjq82Fh9IL22SZw5kLMWV82wP8NyJRkiszleNh7
         72Cc4o0qRSvT6q8LlEitmAEkIl0e5Ijq/bYVgqryVUHszJ/AE+u5yQWtW+9ArJ5S4keh
         qS4RioIvhOQLuXaooUp/TmIwPEHLZDL/5IdkSQvNbB9Uv3FQj5dTFV9BaSNf6xJWMN6r
         SRnw==
X-Gm-Message-State: AOAM5319wkG7H1iIxS3vlJids9Ind/NsB/1Ya3Bmd+tL7fugiTPGFVid
        reWgwaAQ1amnXPZ8Q/iT4b874u3DUUE=
X-Google-Smtp-Source: ABdhPJxATzeD37WNq+6lbxIjAYbSaSOw+3miYA5Iy8k9vA5y7Fd68IZ60I/vkpEMubUlU5UVhAJDMQ==
X-Received: by 2002:aca:a88e:: with SMTP id r136mr5630921oie.101.1632874961889;
        Tue, 28 Sep 2021 17:22:41 -0700 (PDT)
Received: from ?IPV6:2603:80a0:e01:cc2f:be5f:f4ff:fe7b:62ec? (2603-80a0-0e01-cc2f-be5f-f4ff-fe7b-62ec.res6.spectrum.com. [2603:80a0:e01:cc2f:be5f:f4ff:fe7b:62ec])
        by smtp.gmail.com with ESMTPSA id 10sm139823otw.53.2021.09.28.17.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 17:22:41 -0700 (PDT)
Message-ID: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
Date:   Tue, 28 Sep 2021 19:22:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, terrelln@fb.com
Reply-To: B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com
From:   Tom Seewald <tseewald@gmail.com>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Has this been abandoned or will there be future attempts at syncing the
in-kernel zstd with the upstream project?

Tom

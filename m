Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD769197423
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 07:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgC3F4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 01:56:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44729 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgC3F4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 01:56:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so16707256lji.11
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 22:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YO2EXO9bP8Pykvs0ftrZcRN7lL8tcNZsipSwTW/GjY=;
        b=fy3dNDjioTPJlV7uyGQ3Ob8SgQlg2CQ4iOZtI5fUS0u+agQ9x4TkFyzGnEOjdZMsv3
         x5LQhhX0zEYYxaGZc6VpYhfXl0/GxZL0nf7txfFm+qBBe8EjermyuPdkRBhYgmqg3Wyb
         yMw7Op4FbZtpyiGAIoZmNnHdIhbvpjPAroTDwSVOJ+FfX351kfW6RYi/ndXDDJk/AG8v
         8fpQ2e517Q4Npf/LSZPLeaTDBU+1Hg1EkOQfOi0zzDCJ60v8indruO/+vIAsU/30R0iW
         bEA5QOfmD2lY7Pq3mkYjUs0vORq1aXLph6tcRu7bzSEhH01cWuYddUa+OkJEGXzd29Lk
         Xe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5YO2EXO9bP8Pykvs0ftrZcRN7lL8tcNZsipSwTW/GjY=;
        b=udmMZsiHKpJ4MaeKALhFQ1kpVNDBcOhDV+PJT2AZYWGKJFTpwEupxzmARESgu6ppDT
         /3PQoDxtfVbu+qLdJ5IW9hu0W51U+g3oyxHD4A40sIScnjwgwWv1lmnHA27Tdb0dxX80
         dx2x+ucuJxAkbDK488tWr5uaYAkn32fqhNUDyGB53eXCWVMKZ4lRqGchOPO30YH/7AxV
         8AVrOKTelza2KfS003dkdFZpJn4sCiEigsd5BSohIWwjuMZZlPj1wjXdaesDRHMzhxPY
         sfY/Nm70wjhdkW472pCnGz0VEa4oGfmJCWpQS6L9KKEmjUzp2sAPE8ZGc+HWz0jwIxJw
         /ZFQ==
X-Gm-Message-State: AGi0Pua78rEVidpbDs+BCDxbCQMyljb9H+05QaiQNYptIC7id697xZn2
        Hde8f7vUTV4JF2hA53Pkz7s=
X-Google-Smtp-Source: APiQypJAWEFElMxi6l9p3CsU/ZaVV1aHYM7YKS77EHw/BNKGW7fMaZDkHQyhxuICl4w3eKGEGJObYQ==
X-Received: by 2002:a2e:97cd:: with SMTP id m13mr6366651ljj.20.1585547807837;
        Sun, 29 Mar 2020 22:56:47 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed? ([2a00:1370:812d:ea69:5e88:dcf1:68f5:44ed])
        by smtp.gmail.com with ESMTPSA id f24sm2988338lfa.17.2020.03.29.22.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 22:56:47 -0700 (PDT)
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     4brad@templetons.com
References: <94d08f2b57dd2df746436a0d6bb5f51e@wpkg.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <8703e779-d31b-37c1-672b-dea482e8a491@gmail.com>
Date:   Mon, 30 Mar 2020 08:56:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <94d08f2b57dd2df746436a0d6bb5f51e@wpkg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.03.2020 05:29, Tomasz Chmielewski пишет:
>> I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu
>> LTS if it has a data corruption bug.   I don't know if I've seen any
>> release of 5.4.14 in a PPA yet -- manual kernel install is such a pain
>> the few times I have done it.
> 
> You have all kernels compiled as packages here (for Ubuntu):
> 
> https://kernel.ubuntu.com/~kernel-ppa/mainline/
> 
> So just download two deb packages, dpkg -i, and done.
> 

Beware that it is not exactly the same as distribution kernel (both in
terms of included patches and enabled configuration options). Also
matching linux-tools is not provided which means perf, cpupower,
turbostat and some other tools stop working.


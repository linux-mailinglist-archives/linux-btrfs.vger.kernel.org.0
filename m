Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A9E918
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 19:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfD2Rbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 13:31:32 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:44727 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfD2Rbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 13:31:32 -0400
Received: by mail-lj1-f171.google.com with SMTP id c6so3635762lji.11
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NEq5JFCYZruWXi/CMXWijBZNnRHIdGaVPurOkT1qwIQ=;
        b=GE1QbO+j2O7pJezctXzEs//XI91OfMtSKrweZk/TN2xDJS6TSaAwDflStDC2H7nir9
         0+cwTNgn4WLEVtC28rhQCbde4n8r2VbeXDcTIPfM9CjP8O2xVg8hokzx966fzobdUXxj
         Vd9rocHLu89CRnXzCtWMlH2s0FECkYoTYO2wtuHx8/cYZuON1b1NpTWIXBU/6jRzomnL
         YTufI9ili6o8dMNPEhKQXT7iGC2nLjLvPSA2RWGh5sOlCLmFpD/oWd5yp2J0RfY/Oojo
         cWRCyhSdO1oFGakAuXVs8igIrYyDFBC5yIOV4qvgOqPF5aUquEEk9rHPdXWVFHOVlTpL
         JEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NEq5JFCYZruWXi/CMXWijBZNnRHIdGaVPurOkT1qwIQ=;
        b=qXA3eDCTOIaKNeFkb/hbuy5ccRQw/xHvkliZeDB0fhrx6pM2YWuBMNHkt8bc+/yF36
         89zoE7Loi0dfVf9G8EHTt+F1UNv4VkGFkyX14a96p55MNRgWmgtcFI4H7r6fRWR5mBTg
         EBsBBpW/pTDLE8SBaS0FqTr6822xQ/wAVlm4BbCRtAbUPaBgiSRty/Bl2XP+1sJCqPwB
         znsJRtmkC6QwN3zMnJfV3z+nNnLBl4pJicqIOfMhv1xnSDg2dIfrzn6zpwZVqym4+6MR
         yO2/1dtvzcJnZqeqIhVhEH9s1LwMQ2i20HMTUI3wxofq6mk0fGrdxd7Rp04Kz8kasPMH
         u/0Q==
X-Gm-Message-State: APjAAAVQ0GW32tqZblY7YPGtFCP29JTilMErjkPyvLTVaCQvC0TsYbvB
        dbdGb1H5Q97RTJEzR8Z1gAzVM5AasqA=
X-Google-Smtp-Source: APXvYqwqBdAMYlsPswwhCppEiLOoGRJZ6pNPgV4YfcU8YWQ1CdgKpj52LDBjzitU96pXZ3kYObVguA==
X-Received: by 2002:a2e:9b96:: with SMTP id z22mr22564211lji.165.1556559089672;
        Mon, 29 Apr 2019 10:31:29 -0700 (PDT)
Received: from [192.168.1.5] ([109.252.90.193])
        by smtp.gmail.com with ESMTPSA id c24sm345259ljj.46.2019.04.29.10.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:31:28 -0700 (PDT)
Subject: Re: Migration to BTRFS
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Hendrik Friedel <hendrik@friedels.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <emb78b630a-c045-4f12-8945-66a237852402@ryzen>
 <0f1a1f40-c951-05dc-f9fd-d6de5884f782@gmail.com>
 <e27cc7ee-4256-0ccc-a9f1-79cd6898e927@gmail.com>
 <em12ddda3f-4221-4678-aa1c-0854489007e1@ryzen>
 <595b60f2-2a93-2078-93f2-e5952aac1fa3@gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
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
Message-ID: <831d651a-5aa3-e98c-8520-05dd5f55e26d@gmail.com>
Date:   Mon, 29 Apr 2019 20:31:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <595b60f2-2a93-2078-93f2-e5952aac1fa3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

29.04.2019 20:20, Austin S. Hemmelgarn пишет:
> 
>>>> As of today there is no provision for automatic mounting of incomplete
>>>> multi-device btrfs in degraded mode. Actually, with systemd it is flat
>>>> impossible to mount incomplete btrfs because standard framework only
>>>> proceeds to mount it after all devices have been seen.
>> Do you talk about the mount during boot or about mounting in general?
> Both,

Sorry for chiming in, but the quoted part was mine, and I was speaking
about automatic mount during boot. Manual mount using "mount" command
after boot is of course possible (and does not involve systemd in any
way). There is systemd-mount tool which will likely have the same issue.



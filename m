Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863C7320902
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 07:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBUGzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 01:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBUGzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 01:55:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D1DC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 22:54:22 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u4so45662808ljh.6
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 22:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tbaC3efuE0cHOOnCmouDl+cvLTBT9ZuVN1uDXKVGvcI=;
        b=GXbZEEPIqzalFXbwEbViyWyG3K3NOM7QLb46iN+rxAMyV0fmgsoliAhv1jUTRFDUru
         eQ5yhb4hSZaUew0WwYnCPwD+kYbym5CAJGwVmrasH8kzZvq0oDxY9b2v427xYAxN4qBb
         qRK1gUjDYfGrmqsdUyQfLLKBtNPHh0zMi6Ml/fhSTJ6zpnZD8DpULT1ruBy3l9x8nBty
         7TEcZlz/oETbv3FhmBEeAELuUNLHXihI+sRid53lqZxs/cKY/POIaY8Killgr/1vZNoj
         OoL0JFMOPHZK2Z9kOtzjkKQgpWkQLLqZWQQbKWtZkDPhSlW8CzW+ngbXV03suh+KMnpo
         vIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tbaC3efuE0cHOOnCmouDl+cvLTBT9ZuVN1uDXKVGvcI=;
        b=fwquiFD8c+SptgTeuy3nUQq6zndt4khCz5UlY02vYsFGepyFeHuYpe24Nmp1KWZVrn
         DzMszdqzJV0hZ1+lDLKFFOcNHlzWJzVJ3nMgF8azg3AGOzxbojEupv5QQJEHxzzjJnj3
         HdO+viF3b+KhFX8C5lIlKJwoQ+bKBSx6bltBRAwMOQ9UikmA+E6Ds48nsdZihLdECV3w
         F+9dyIdeeAIRn94taGUXdgY6bChzh9SAdgcLkhQBnZYiSINfdfHLJF9vHDg+4WgXH22v
         tjYmeVj3vDMpuY7dQt8t5Z2gQx4OqARq99T07PtZQ88OKWZhR7Hu4CKOqGAMObfEnLnQ
         CDZg==
X-Gm-Message-State: AOAM532aQE/l6NBDy9OuWIY2iL+ITmy537DbLVFfP71pDjIBjm4gQkco
        w1LFh5NOk7I9lfih3bfpJ/3kha/gnp8=
X-Google-Smtp-Source: ABdhPJwcHG6sIdbNDMt2FeEsWOt3N5bh5v8Q/6814AmSh4gZ2Dvy3FUw6uKT5z+8yXISUhYafpeBdg==
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr10640618ljc.296.1613890460411;
        Sat, 20 Feb 2021 22:54:20 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:f67d:23b0:24c5:db70:4d19? ([2a00:1370:812d:f67d:23b0:24c5:db70:4d19])
        by smtp.gmail.com with ESMTPSA id f2sm1505577lfc.240.2021.02.20.22.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Feb 2021 22:54:20 -0800 (PST)
Subject: Re: Unexpected "ERROR: clone: did not find source subvol" on btrfs
 receive
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-btrfs@vger.kernel.org
References: <41b096e1-5345-ae9c-810b-685499813183@wetzel-home.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <0fcbd697-11c5-0b32-7e08-80cf8d355271@gmail.com>
Date:   Sun, 21 Feb 2021 09:54:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <41b096e1-5345-ae9c-810b-685499813183@wetzel-home.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

20.02.2021 20:45, Alexander Wetzel пишет:
> 
> # time btrfs receive -v -f test2 .
> receiving snapshot 2021-02-20-TEMP
> uuid=120113e6-f83c-b240-ba27-259be4c92ea7, ctransid=206769
> parent_uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89, parent_ctransid=195056
...
> write var/lib/mysql/nextcloud/oc_activity.ibd - offset=737280 length=8192
> ERROR: clone: did not find source subvol

Unforutnately btrfs receive does not print clone source UUID even with
"btrfs receive --dump". The best is to modify process_clone to print
full command including UUID which was not found.


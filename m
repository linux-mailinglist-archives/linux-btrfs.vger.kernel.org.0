Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F20147773
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 05:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgAXEDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 23:03:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38327 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbgAXEDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 23:03:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so275001lfm.5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 20:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pJ79YEzqOeJqBHZrWiE140mizvbe/bZRpHvpfHBK80U=;
        b=VCHxDBvEQn8WjrC9CdoL4k3bwTrG5ncqnnVztmUBJzeJLCKAqcF8m+84CFxTH3zv+f
         GH2EhmsjLr9vRXh4TRlg3fEiFEb+mhhq4mh+tAbml7WpLgvQDL84vCtuEILRLwmib6LR
         Q1RXHfgbX/29Kx9D9i0I2/oCQakbw9I4iCTlTd3To5F4cp2HVPwvCHaTpqoh7nMCi+2x
         JP4QLkVM6qbleK4B9PXRHcJkByV9GrdidSyKTAELjBWpNMictnJWz+DGkRINiEZwYOFb
         UMi7rSeYPxXlEYI2gqXf4t3M2A/EFpPNqF6TJSUOH2x8FqCBO0naleCMYBUQDKrWdJkY
         ZUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pJ79YEzqOeJqBHZrWiE140mizvbe/bZRpHvpfHBK80U=;
        b=fbDdEUFyG+vX+xmn9m5xivYMe/8toMpjnBRvsW3V7RbZuyoi8z1VgQ3/cv1zYFfgN1
         ClTL5C22V91/aP2eJXsYm6UW1dNNLODkThO2wsNzEVvns/1KOjugzcymaXZ/AkDVliO8
         ab2redPwfccJLAhQjW591pwW2nhiI/FqrGsHx6r3AuPohjJljVUJemLxXZcWFdwT6ekX
         h9IF1qW5zBVnDQbfz+0N9hrjqpHM68BNL24i9CFczLbmbXhj90Wuxomm+ZAfxIROuf7o
         ugXDyA76+SLeaxpCDHofzHtt2/4KUeTz6q3lc4E8nMYkEOJY/rqeVqaRg4zNSWgyUkqn
         witg==
X-Gm-Message-State: APjAAAUePabwemPnHgj+mwoI2jaw89YS/Eaj/c5rVErbzRrc0qJS/S+b
        I59WYOAi/F3vFgKdNaRp7cg=
X-Google-Smtp-Source: APXvYqwS1XCK6+4U1IXXwXyL/SqBpKrKHn4r+uYj39r4OfgxI6p9VVq0sLQNz7l8rMsbP3v4l0OAQg==
X-Received: by 2002:a19:23d7:: with SMTP id j206mr479310lfj.108.1579838616979;
        Thu, 23 Jan 2020 20:03:36 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:af15:a51e:b905:dd2b:45cf? ([2a00:1370:812d:af15:a51e:b905:dd2b:45cf])
        by smtp.gmail.com with ESMTPSA id z7sm2279852lji.30.2020.01.23.20.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:03:36 -0800 (PST)
Subject: Re: Hibernation into swap file
To:     Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Omar Sandoval <osandov@fb.com>
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <20190506113226.GL20156@twin.jikos.cz>
 <CAJCQCtSLYY-AY8b1WZ1D4neTrwMsm_A61-G-8e6-H3Dmfue_vQ@mail.gmail.com>
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
Message-ID: <859d7c9a-89af-f25b-4e83-027febf8715e@gmail.com>
Date:   Fri, 24 Jan 2020 07:03:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSLYY-AY8b1WZ1D4neTrwMsm_A61-G-8e6-H3Dmfue_vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.01.2020 20:20, Chris Murphy пишет:
> On Mon, May 6, 2019 at 5:31 AM David Sterba <dsterba@suse.cz> wrote:
>> for the reference https://bugzilla.kernel.org/show_bug.cgi?id=202803
>> and https://github.com/systemd/systemd/issues/11939
> 
> I've read these, but can't tell if it's still necessary to manually
> use 'btrfs-map-physical' to find the correct offset, and use it on the
> kernel command line manually?

Yes, it is. systemd does not compute it automatically.

> It does sound like contiguous extents is
> not a requirement for hibernation to a swapfile on btrfs. Correct?
> 
> The idea I'm evaluating is a way to dynamically enable a swapfile only
> at hibernation time. That way there's no swap thrashing during normal
> use, yet it's still possible to support hibernation. It'd be necessary
> to insert the swapon quickly after a request (or pre-trigger, maybe by
> upowerd) for hibernation, so that the various systemd tests already
> find a suitable swap device for the hibernation image.
> 
> 
> --
> Chris Murphy
> 


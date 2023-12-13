Return-Path: <linux-btrfs+bounces-896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0033B810C73
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BE4B20DAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257B1EB39;
	Wed, 13 Dec 2023 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOlGj19R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55995F3
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 00:29:52 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-425a3cdbda9so38742151cf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 00:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702456191; x=1703060991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeySgjBeBTVR8JRwqlBoJfOZW/VwvjKG9Pg60eHL25Y=;
        b=MOlGj19RJJ7X6+m329j9N/sQE7BX4pnCINEgcwodJy7qe0uBmnB+mM/4Q1uJaCtXJQ
         BkxZM8lTSnPp9b9CKYXhfWnTq7XQBH8Cy8nkDJI4FjHQXOwBZHhKpHtRdMNkmar2sk7T
         Mg+ro0g4h6weXvbB1IW5rsqNJqeFdzWbhpyWZibDSKNmp5iUt1pvzV2BIBug+F6IayuB
         LMzb+oeZU5gYgDhSwH+b84UB/ES4KExeH3jnuz+eHfTcBn7zE6DeXxAejPckS1GVyH2S
         /Yh9Ht0haQ65AlW7BjwNuJhs0oBKnk+WvlltLAAb6OJE5rWqnM91kvnsfqB8q8thsbU2
         Zw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702456191; x=1703060991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeySgjBeBTVR8JRwqlBoJfOZW/VwvjKG9Pg60eHL25Y=;
        b=ZJlBYIzZxxX9l81AGPPYRE5VMcYOpEtLEgiMILtqms4eaq4X6HRXDRBIVJTHbdXaUe
         l47irjsmT7+Sbf7YqUgcJbQzoVZu12mHtn6CSMXLc9i37A2vm0HgaqutQF2YawKnYGda
         FWwDho23yCpOp3yP7eUMMTObDiripBAjZMKbQbAJH3yETdHjYjq8Tzqg6Xa/r3GcA146
         docfLQPRMpZ59ILHDHwOycfaZH76fYFm6v1WKl0iBUIAbVLb9nkC7w5LGEXvse9SlNw/
         3ozSz8Hfy339o2U5pkS//s287vpA6oJnFdVna6H4AZbNEJNNSRf4jrrKccfS/iytet2J
         zTuw==
X-Gm-Message-State: AOJu0YyLBviXKV4JCP8uz3Uv39WgOeFnbdAu3GR+fsy/FOMUDrMt92Zi
	5yeOKOpOtRoYV50xNMotqkV/+AF58aPqbJX8NqYw/9DjYGHQiQ==
X-Google-Smtp-Source: AGHT+IHviiXmc/7ePeYZkUGFe5DHj5jDDZ2hpp/Hkwife0CWEMYnjFYf1jzi2VO90+LZL+v3t9x2CBnhrd2wjj2Ist8=
X-Received: by 2002:a05:622a:1113:b0:425:615f:2fc8 with SMTP id
 e19-20020a05622a111300b00425615f2fc8mr11184964qty.61.1702456191330; Wed, 13
 Dec 2023 00:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com> <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com> <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com> <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
In-Reply-To: <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Wed, 13 Dec 2023 09:29:35 +0100
Message-ID: <CAK-xaQY-BRCtG0=BjqTfFG5GhmkZnbS7SX-2ysXKeNqQ+3mG5w@mail.gmail.com>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 12 dic 2023 alle ore 01:12 Christoph Anton Mitterer
<calestyo@scientia.org> ha scritto:
> Is there a way to check this? Would I just seem maaany extents when I
> look at the files with filefrag?

I use this:
https://github.com/CyberShadow/btdu.git

And no, maaannyyyy extents don't imply wasted space

